import XCTest
@testable import fuze

final class FuzeColorsTests: XCTestCase {
    func test_colors_givenInstantiated_shouldAllColorNamesAreCorrect() {
        XCTAssertNotNil(UIColor.primaryBackground)
        XCTAssertNotNil(UIColor.secondaryBackground)
        XCTAssertNotNil(UIColor.primaryGrey)
        XCTAssertNotNil(UIColor.secondaryGrey)
        XCTAssertNotNil(UIColor.tertiaryGrey)
        XCTAssertNotNil(UIColor.primaryRed)
        XCTAssertNotNil(UIColor.secondaryRed)
        XCTAssertNotNil(UIColor.primaryWhite)
        XCTAssertNotNil(UIColor.primaryBlue)
    }
}
