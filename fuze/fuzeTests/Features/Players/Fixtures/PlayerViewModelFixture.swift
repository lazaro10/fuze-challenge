@testable import fuze

extension PlayerViewModel {
    static func fixture() -> PlayerViewModel {
        .init(imageURL: nil, nickname: "xc", name: "Cheng Xing", alignment: .right)
    }
}
