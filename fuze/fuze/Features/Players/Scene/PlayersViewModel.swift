import Foundation

enum PlayersAligment {
    case left
    case right
}

protocol PlayersViewModelLogic {
    func fetchPlayers()
    func refreshPlayers()
    func fetchMorePlayers()
}

final class PlayersViewModel {
    private(set) var page = 1
    private(set) var isContinuePagination = true
    private var players: [PlayerModel] = []

    weak var display: PlayersViewControllerDisplayble?
    
    private let teamId: Int
    private let alignment: PlayersAligment
    private let repository: PlayersRepositoryLogic
    private let converter: PlayersConverterLogic

    init(teamId: Int, alignment: PlayersAligment, repository: PlayersRepositoryLogic, converter: PlayersConverterLogic) {
        self.teamId = teamId
        self.alignment = alignment
        self.repository = repository
        self.converter = converter
    }

    private func setupInitialState() {
        page = 1
        isContinuePagination = true
        players = []
    }
}

extension PlayersViewModel: PlayersViewModelLogic {
    func fetchPlayers() {
        isContinuePagination = false
        repository.fetchPlayers(page: page, teamId: teamId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let players):
                self.players.append(contentsOf: players)
                self.page += 1
                self.isContinuePagination = !players.isEmpty
                self.display?.displayPlayers(self.converter.convert(self.players, alignment: self.alignment))

                if players.isEmpty {
                    self.display?.notifyPlayersAreFinished()
                }
            case .failure:
                self.isContinuePagination = false
                self.display?.notifyPlayersAreFinished()
            }
        }
    }

    func refreshPlayers() {
        setupInitialState()
        fetchPlayers()
    }

    func fetchMorePlayers() {
        if isContinuePagination {
            fetchPlayers()
        }
    }
}
