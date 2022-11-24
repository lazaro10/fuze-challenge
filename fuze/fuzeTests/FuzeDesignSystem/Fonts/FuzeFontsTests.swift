import XCTest
@testable import fuze

final class FuzeFontsTests: XCTestCase {
    func test_robotoMedium_whenCreated_shouldReturnAValidFont() {
        let robotoMedium: UIFont = .robotoMeidum(size: 16)

        XCTAssertEqual(robotoMedium.familyName, "Roboto")
        XCTAssertEqual(robotoMedium.fontName, "Roboto-Medium")
        XCTAssertEqual(robotoMedium.pointSize, 16)
    }

    func test_robotoRegular_whenCreated_shouldReturnAValidFont() {
        let robotoMedium: UIFont = .robotoRegular(size: 12)

        XCTAssertEqual(robotoMedium.familyName, "Roboto")
        XCTAssertEqual(robotoMedium.fontName, "Roboto-Regular")
        XCTAssertEqual(robotoMedium.pointSize, 12)
    }

    func test_robotoBold_whenCreated_shouldReturnAValidFont() {
        let robotoMedium: UIFont = .robotoBold(size: 15)

        XCTAssertEqual(robotoMedium.familyName, "Roboto")
        XCTAssertEqual(robotoMedium.fontName, "Roboto-Bold")
        XCTAssertEqual(robotoMedium.pointSize, 15)
    }
}


