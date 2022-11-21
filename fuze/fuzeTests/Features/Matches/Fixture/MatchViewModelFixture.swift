@testable import fuze

extension MatchViewModel {
    static func fixture() -> MatchViewModel {
        .init(
            id: 20,
            matchTime: "22.04 15:00",
            matchTimeViewColor: nil,
            confrontationViewModel: .fixture(),
            leagueImageURL: nil,
            leagueSerie: "Season 6 2022"
        )
    }
}
