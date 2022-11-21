import XCTest
@testable import fuze

final class MatchesNetworkRequestTests: XCTestCase {
    func test_givenUpcomingCase_whenInstantiated_shouldConfigureCorrectly() {
        let sut = MatchesNetworkRequest.upcoming(page: 3)

        XCTAssertEqual(sut.parameters["page"], "3")
        XCTAssertEqual(sut.parameters["per_page"], "10")
        XCTAssertEqual(sut.path, "/csgo/matches/upcoming")
        XCTAssertEqual(sut.method, .get)
    }

    func test_givenRunningCase_whenInstantiated_shouldConfigureCorrectly() {
        let sut = MatchesNetworkRequest.running(page: 2)

        XCTAssertEqual(sut.parameters["page"], "2")
        XCTAssertEqual(sut.parameters["per_page"], "10")
        XCTAssertEqual(sut.path, "/csgo/matches/running")
        XCTAssertEqual(sut.method, .get)
    }
}
