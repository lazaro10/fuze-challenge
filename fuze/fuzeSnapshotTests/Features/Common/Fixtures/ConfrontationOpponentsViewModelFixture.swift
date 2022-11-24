@testable import fuze

extension ConfrontationOpponentsViewModel {
    static func fixture() -> ConfrontationOpponentsViewModel {
        .init(
            leftOpponentImageURL: nil,
            rightOpponentImageURL: nil,
            leftOpponentName: "VP.Prodigy",
            rightOpponentName: "Entropiq Prague",
            leftOpponentId: 0,
            rightOpponentId: 0
        )
    }
}
