@testable import fuze

extension MatchModel {
    static func fixture() -> MatchModel {
        .init(
            id: 20,
            beginAt: "2022-11-20T09:30:00Z",
            opponents: [
                Opponent(opponent: Opponent.OpponentData(name: "180mgkoffein", imageUrl: nil, id: 3454)),
                Opponent(opponent: Opponent.OpponentData(name: "SKADE X", imageUrl: nil, id: 4543))
            ],
            league: League(name: "Closed Qualifier", imageUrl: nil),
            serie: Serie(fullName: "Season 6 2022"),
            status: .notPayed
        )
    }
}
