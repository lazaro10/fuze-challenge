import XCTest
@testable import fuze

final class LocalizableTests: XCTestCase {
    func test_strings_whenCalled_shouldAllTextsAreCorrect() {
        XCTAssertEqual(Strings.matches, "Matches")
        XCTAssertEqual(Strings.now, "NOW")
        XCTAssertEqual(Strings.tryAgain, "Try again")
        XCTAssertEqual(Strings.matchNotFound, "We couldn't find any matches at this time.")
        XCTAssertEqual(Strings.matchesNotLoaded, "We were unable to load the matches, please try again.")
    }
}
