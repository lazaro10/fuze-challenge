@testable import fuze

extension ConfrontationOpponentsViewModel {
    static func fixture() -> ConfrontationOpponentsViewModel {
        .init(
            leftOpponentImageURL: nil,
            rightOpponentImageURL: nil,
            leftOpponentName: "Anonymo",
            rightOpponentName: "SKADE X"
        )
    }
}
