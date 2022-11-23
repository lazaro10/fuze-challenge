@testable import fuze

extension MatchViewModel {
    static func fixture() -> MatchViewModel {
        .init(
            id: 20,
            matchTime: "Sun 06:30",
            matchTimeViewColor: nil,
            confrontationViewModel: .fixture(),
            leagueImageURL: nil,
            leagueSerie: "Closed Qualifier Season 6 2022"
        )
    }
}

