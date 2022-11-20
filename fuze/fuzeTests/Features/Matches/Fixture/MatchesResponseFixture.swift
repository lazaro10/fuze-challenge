@testable import fuze

extension MatchesResponse {
    static func fixture() -> MatchesResponse {
        .init(
            beginAt: "2022-11-20T09:30:00Z",
            opponents: [Opponent(opponent: Opponent.OpponentData(name: "180mgkoffein", imageUrl: nil))],
            league: League(name: "Closed Qualifier"),
            serie: Serie(fullName: "Season 6 2022")
        )
    }
}
