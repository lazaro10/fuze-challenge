import XCTest
@testable import fuze

final class FontsTests: XCTestCase {
    func test_robotoMeidum_whenCreated_shouldReturnAValidFont() {
        let robotoMedium: UIFont = .robotoMeidum(size: 16)

        XCTAssertEqual(robotoMedium.familyName, "Roboto")
        XCTAssertEqual(robotoMedium.fontName, "Roboto-Medium")
        XCTAssertEqual(robotoMedium.pointSize, 16)
    }
}


