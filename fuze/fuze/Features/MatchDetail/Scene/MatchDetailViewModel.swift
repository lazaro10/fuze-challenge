import Foundation

final class MatchDetailViewModel {
    private(set) var leftPlayersPage = 1
    private(set) var isContinueLeftPlayersPagination = true
    private var leftPlayers: [PlayerModel] = []

    private(set) var rightPlayersPage = 1
    private(set) var isContinueRightPlayersPagination = true
    private var rightPlayers: [PlayerModel] = []

    private let matchViewMode: MatchViewModel
    private let leftTeamId: Int
    private let rightTeamId: Int
    private let repository: PlayersRepositoryLogic

    init(matchViewMode: MatchViewModel, leftTeamId: Int, rightTeamId: Int, repository: PlayersRepositoryLogic) {
        self.matchViewMode = matchViewMode
        self.leftTeamId = leftTeamId
        self.rightTeamId = rightTeamId
        self.repository = repository
    }

    private func fetchLeftPlayers() {
        repository.fetchPlayers(page: leftPlayersPage, teamId: <#T##Int#>, completion: <#T##(Result<[PlayerModel], Error>) -> Void#>)
    }

    private func fetchRightPlayers() {

    }
}
