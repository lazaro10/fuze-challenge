@testable import fuze
import UIKit

extension MatchViewModel {
    static func fixture(
        matchTime: String = "Today, 11:00 AM",
        matchTimeViewColor: UIColor? = .tertiaryGrey
    ) -> MatchViewModel {
        .init(
            id: 23,
            matchTime: matchTime,
            matchTimeViewColor: matchTimeViewColor,
            confrontationViewModel: .fixture(),
            leagueImageURL: nil,
            leagueSerie: "Winline Insight | Season 2 2022"
        )
    }
}
