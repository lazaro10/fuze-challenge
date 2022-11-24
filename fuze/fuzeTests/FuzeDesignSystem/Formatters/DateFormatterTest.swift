import XCTest
@testable import fuze

final class DateFormatterTest: XCTestCase {
    func test_toDateZ_shouldFormatCorrectly() {
        let sut = "2022-11-23T08:09:40Z".toDateZ()

        XCTAssertNotNil(sut)
    }

    func test_toShortDate_shouldFormatCorrectly() {
        let date = "2022-11-23T08:09:40Z".toDateZ()
        let sut = date?.toShortDate()

        XCTAssertEqual(sut, "Today, 5:09 AM")
    }

    func test_toMediumDate_shouldFormatCorrectly() {
        let date = "2022-11-23T08:09:40Z".toDateZ()
        let sut = date?.toMediumDate()

        XCTAssertEqual(sut, "Wed 05:09")
    }

    func test_toLongDate_shouldFormatCorrectly() {
        let date = "2022-11-23T08:09:40Z".toDateZ()
        let sut = date?.toLongDate()

        XCTAssertEqual(sut, "23.11 05:09")
    }
}
