import XCTest
@testable import fuze

final class FuzeColorsTests: XCTestCase {
    func test_colors_givenInstantiated_shouldAllNamesAreCorrect() {
        XCTAssertNotNil(UIColor.primaryBackground)
        XCTAssertNotNil(UIColor.secondaryBackground)
        XCTAssertNotNil(UIColor.primaryGrey)
        XCTAssertNotNil(UIColor.secondaryGrey)
        XCTAssertNotNil(UIColor.primaryRed)
    }
}
