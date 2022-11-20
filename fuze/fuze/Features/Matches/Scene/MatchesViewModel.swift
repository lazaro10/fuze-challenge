protocol MatchesViewModelLogic {
    func fetchMatches()
    func fetchMoreMatches()
}

final class MatchesViewModel {
    private var runningMachesPage = 1
    private var upcomeMachesPage = 1
    private var isContinuePagination = true
    private var matches: [MatchesResponse] = []

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
                    self.fetchRunningMatches()
                }
            case .failure:
                self.fetchUpcomingMatches()
            }
        }
    }

    private func fetchUpcomingMatches() {
        if isContinuePagination {
            repository.fetchUpcomingMatches(page: upcomeMachesPage) { [weak self] result in
                guard let self = self else { return }

                switch result {
                case .success(let matches):
                    self.matches.append(contentsOf: matches)
                    self.upcomeMachesPage += 1

                    self.display?.displayMatchViewModels(viewModels: self.convertMatches())
                case .failure:
                    if self.matches.isEmpty {
                        // show error
                    }
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
                matchTime: $0.beginAt,
                matchTimeViewColor: .tertiaryGrey,
                confrontationViewModel: confrontationViewModel,
                leagueImageURL: $0.league.imageUrl,
                leagueSerie: "\($0.league.name) | \($0.serie.fullName)"
            )
        }
    }

    private func setupInitialState() {
        runningMachesPage = 1
        upcomeMachesPage = 1
        isContinuePagination = true
        matches = []
    }
}

extension MatchesViewModel: MatchesViewModelLogic {
    func fetchMatches() {
        setupInitialState()
        fetchRunningMatches()
    }

    func fetchMoreMatches() {
        fetchUpcomingMatches()
    }
}
