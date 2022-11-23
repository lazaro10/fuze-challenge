protocol MatchesConverterLogic {
    func convert(_ match: MatchModel) -> MatchViewModel
    func convert(_ matches: [MatchModel]) -> [MatchViewModel]
}

struct MatchesConverter: MatchesConverterLogic {
    func convert(_ match: MatchModel) -> MatchViewModel {
        let confrontationViewModel = ConfrontationOpponentsViewModel(
            leftOpponentImageURL: match.opponents[0].opponent.imageUrl,
            rightOpponentImageURL: match.opponents[1].opponent.imageUrl,
            leftOpponentName: match.opponents[0].opponent.name,
            rightOpponentName: match.opponents[1].opponent.name,
            leftOpponentId: match.opponents[0].opponent.id,
            rightOpponentId: match.opponents[1].opponent.id
        )

        let matchTime: String

        switch match.status {
        case .running:
            matchTime = Strings.now
        case .canceled:
            matchTime = Strings.canceled
        default:
            matchTime = (match.beginAt ?? "").toMatchDate()
        }

        return MatchViewModel(
            id: match.id,
            matchTime: matchTime,
            matchTimeViewColor: match.status == .running ? .primaryRed : .tertiaryGrey,
            confrontationViewModel: confrontationViewModel,
            leagueImageURL: match.league.imageUrl,
            leagueSerie: "\(match.league.name) | \(match.serie.fullName)"
        )
    }

    func convert(_ matches: [MatchModel]) -> [MatchViewModel] {
        return matches.map {
            convert($0)
        }
    }
}
