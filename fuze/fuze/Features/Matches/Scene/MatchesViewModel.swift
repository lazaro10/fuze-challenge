protocol MatchesViewModelLogic {
    func fetchMatches()
    func fetchMoreMatches()
}

final class MatchesViewModel {
    private(set) var runningMachesPage = 1
    private(set) var isContinueRunningPagination = true
    private(set) var upcomeMachesPage = 1
    private(set) var isContinueUpcomePagination = true
    private(set) var matches: [MatchModel] = []
    weak var display: MatchesViewControllerDisplayble?

    private let repository: MatchesRepositoryLogic

    init(repository: MatchesRepositoryLogic) {
        self.repository = repository
    }

    private func fetchRunningMatches() {
        repository.fetchRunningMatches(page: runningMachesPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let matches):
                self.matches.append(contentsOf: matches)
                self.runningMachesPage += 1

                if matches.isEmpty {
                    self.fetchUpcomingMatches()
                } else {
                    if matches.count == 10 {
                        self.isContinueRunningPagination = true
                        self.display?.displayState(.content(viewModels: self.convertMatches()))
                    } else {
                        self.fetchUpcomingMatches()
                    }
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
                self.matches.append(contentsOf: matches)
                self.upcomeMachesPage += 1

                if matches.isEmpty {
                    self.isContinueUpcomePagination = false
                    if self.matches.isEmpty {
                        self.display?.displayState(.empty)
                    }
                } else {
                    self.isContinueUpcomePagination = true
                    self.display?.displayState(.content(viewModels: self.convertMatches()))
                }
            case .failure:
                self.isContinueUpcomePagination = false
                if self.matches.isEmpty {
                    self.display?.displayState(.error)
                }
            }
        }
    }

    private func convertMatches() -> [MatchViewModel] {
        let matchesFiltered = matches.filter {
            $0.opponents.count == 2
        }

        return matchesFiltered.map {
            let confrontationViewModel = ConfrontationOpponentsViewModel(
                leftOpponentImageURL: $0.opponents[0].opponent?.imageUrl,
                rightOpponentImageURL: $0.opponents[1].opponent?.imageUrl,
                leftOpponentName: $0.opponents[0].opponent?.name ?? "",
                rightOpponentName: $0.opponents[1].opponent?.name ?? ""
            )

            return MatchViewModel(
                id: $0.id,
                matchTime: $0.status == .running ? Strings.now : $0.beginAt.toDateZ()?.toMatchDate() ?? "-",
                matchTimeViewColor: $0.status == .running ? .primaryRed : .tertiaryGrey,
                confrontationViewModel: confrontationViewModel,
                leagueImageURL: $0.league.imageUrl,
                leagueSerie: "\($0.league.name) | \($0.serie.fullName)"
            )
        }
    }

    private func setupInitialState() {
        runningMachesPage = 1
        isContinueRunningPagination = true
        upcomeMachesPage = 1
        isContinueUpcomePagination = true
        matches = []
    }
}
extension MatchesViewModel: MatchesViewModelLogic {
    func fetchMatches() {
        display?.displayState(.loading)
        setupInitialState()
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
}
