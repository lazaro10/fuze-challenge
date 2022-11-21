protocol MatchesViewModelLogic {
    func fetchMatches()
    func fetchMoreMatches()
}

final class MatchesViewModel {
    private var runningMachesPage = 1
    private var isContinueRunningPagination = true
    private var upcomeMachesPage = 1
    private var isContinueUpcomePagination = true
    private var matches: [MatchesResponse] = []
    weak var display: MatchesViewControllerDisplayble?

    private let repository: MatchesRepositoryLogic

    init(repository: MatchesRepositoryLogic) {
        self.repository = repository
    }

    private func fetchRunningMatches() {
        // Show Load
        repository.fetchRunningMatches(page: runningMachesPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let matches):
                self.runningMachesPage += 1

                if matches.isEmpty {
                    self.fetchUpcomingMatches()
                    self.isContinueRunningPagination = false
                } else {
                    self.display?.displayMatchViewModels(viewModels: self.convertMatches())
                    self.matches.append(contentsOf: matches)
                    self.isContinueRunningPagination = true
                    // Hide Load
                }
            case .failure:
                self.fetchUpcomingMatches()
            }
        }
    }

    private func fetchUpcomingMatches() {
        repository.fetchUpcomingMatches(page: upcomeMachesPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let matches):
                self.upcomeMachesPage += 1

                if !matches.isEmpty {
                    self.matches.append(contentsOf: matches)
                    self.display?.displayMatchViewModels(viewModels: self.convertMatches())
                    self.isContinueUpcomePagination = true
                    // Hide Load
                }
            case .failure:
                if self.matches.isEmpty {
                    // show error
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
