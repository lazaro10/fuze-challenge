@testable import fuze

extension ConfrontationOpponentsViewModel {
    static func fixture() -> ConfrontationOpponentsViewModel {
        ConfrontationOpponentsViewModel(
            leftOpponentImageURL: nil,
            rightOpponentImageURL: nil,
            leftOpponentName: "180mgkoffein",
            rightOpponentName: "SKADE X",
            leftOpponentId: 3454,
            rightOpponentId: 4543
        )
    }
}
