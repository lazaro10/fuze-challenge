import XCTest
@testable import fuze

final class LocalizableTests: XCTestCase {
    func test_strings_whenCalled_shouldAllTextsAreCorrect() {
        XCTAssertEqual(Strings.matches, "Matches")
        XCTAssertEqual(Strings.now, "NOW")
    }
}
