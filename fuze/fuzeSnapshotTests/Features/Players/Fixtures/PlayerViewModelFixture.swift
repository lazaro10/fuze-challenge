@testable import fuze
import UIKit

extension PlayerViewModel {
    static func fixture(alignment: PlayersAligment) -> PlayerViewModel {
        .init(imageURL: nil, nickname: "kwezz", name: "IceBerg", alignment: alignment)
    }
}
