import Foundation

protocol MatchesViewModelLogic {
    func fetchMatches()
    func fetchMoreMatches()
    func refreshMatches()
    func selectMatch(index: Int)
}

final class MatchesViewModel {
    private(set) var runningMachesPage = 1
    private(set) var isContinueRunningPagination = true
    private(set) var upcomeMachesPage = 1
    private(set) var isContinueUpcomePagination = true
    private(set) var matches: [MatchModel] = []
    weak var display: MatchesViewControllerDisplayble?

    private let repository: MatchesRepositable
    private let converter: MatchesConvertable

    init(repository: MatchesRepositable, converter: MatchesConvertable) {
        self.repository = repository
        self.converter = converter
    }

    private func setupInitialState() {
        runningMachesPage = 1
        isContinueRunningPagination = true
        upcomeMachesPage = 1
        isContinueUpcomePagination = true
        matches = []
    }

    private func setupMatchesToDisplay(matches: [MatchModel]) {
        let matchesFiltered = matches.filter {
            $0.opponents.count == 2
        }
        self.matches.append(contentsOf: matchesFiltered)
        self.display?.displayState(.content(viewModels: self.converter.convert(self.matches)))
    }

    private func fetchRunningMatches() {
        repository.fetchRunningMatches(page: runningMachesPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let matches):
                self.runningMachesPage += 1

                if matches.count < 10 {
                    self.fetchUpcomingMatches()
                } else {
                    self.isContinueRunningPagination = true
                    self.setupMatchesToDisplay(matches: matches)
                }

            case .failure:
                self.fetchUpcomingMatches()
            }
        }
    }

    private func fetchUpcomingMatches() {
        isContinueRunningPagination = false

        repository.fetchUpcomingMatches(page: upcomeMachesPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let matches):
                self.upcomeMachesPage += 1

                if matches.count < 10 {
                    self.isContinueUpcomePagination = false
                    self.display?.notifyPlayersAreFinished()
                    
                    if self.matches.isEmpty {
                        self.display?.displayState(.empty)
                    }
                } else {
                    self.isContinueUpcomePagination = true
                    self.setupMatchesToDisplay(matches: matches)
                }
            case .failure:
                self.isContinueUpcomePagination = false
                self.display?.notifyPlayersAreFinished()
                if self.matches.isEmpty {
                    self.display?.displayState(.error)
                }
            }
        }
    }
}

extension MatchesViewModel: MatchesViewModelLogic {
    func fetchMatches() {
        display?.displayState(.loading)
        fetchRunningMatches()
    }

    func fetchMoreMatches() {
        if isContinueRunningPagination {
            isContinueRunningPagination = false
            fetchRunningMatches()
        } else if isContinueUpcomePagination {
            isContinueUpcomePagination = false
            fetchUpcomingMatches()
        }
    }

    func refreshMatches() {
        setupInitialState()
        fetchRunningMatches()
    }

    func selectMatch(index: Int) {
        display?.displayMatchDetail(matchViewModel: converter.convert(matches[index]))
    }
}
