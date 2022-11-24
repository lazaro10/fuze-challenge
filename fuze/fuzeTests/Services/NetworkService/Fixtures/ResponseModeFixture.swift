import XCTest
@testable import fuze

struct ResponseModel: Decodable {
    let firstParam: String
    let secondParam: Int
}

extension ResponseModel {
    static func fixture() -> ResponseModel {
        ResponseModel(firstParam: "fuze", secondParam: 456)
    }
}
