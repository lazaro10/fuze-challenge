import XCTest
@testable import fuze

final class DateFormatterTest: XCTestCase {
    func test_toDateZ_shouldFormatCorrectly() {
        let sut = "2035-10-23T08:09:40Z".toDateZ()

        XCTAssertNotNil(sut)
    }

    func test_toShortDate_shouldFormatCorrectly() {
        let date = "2035-10-23T08:09:40Z".toDateZ()
        let sut = date?.toShortDate()

        XCTAssertEqual(sut, "10/23/35, 5:09 AM")
    }

    func test_toMediumDate_shouldFormatCorrectly() {
        let date = "2035-10-23T08:09:40Z".toDateZ()
        let sut = date?.toMediumDate()

        XCTAssertEqual(sut, "Tue 05:09")
    }

    func test_toLongDate_shouldFormatCorrectly() {
        let date = "2035-10-23T08:09:40Z".toDateZ()
        let sut = date?.toLongDate()

        XCTAssertEqual(sut, "23.10 05:09")
    }
}
