protocol MatchesConverterLogic {
    func convert(_ matches: [MatchModel]) -> [MatchViewModel]
}

struct MatchesConverter: MatchesConverterLogic {
    func convert(_ matches: [MatchModel]) -> [MatchViewModel] {
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

            let matchTime: String

            switch $0.status {
            case .running:
                matchTime = Strings.now
            case .canceled:
                matchTime = Strings.canceled
            default:
                matchTime = $0.beginAt.toMatchDate()
            }

            return MatchViewModel(
                id: $0.id,
                matchTime: matchTime,
                matchTimeViewColor: $0.status == .running ? .primaryRed : .tertiaryGrey,
                confrontationViewModel: confrontationViewModel,
                leagueImageURL: $0.league.imageUrl,
                leagueSerie: "\($0.league.name) | \($0.serie.fullName)"
            )
        }
    }
}
