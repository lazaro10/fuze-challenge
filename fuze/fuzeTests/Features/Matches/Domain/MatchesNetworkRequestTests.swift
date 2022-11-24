import XCTest
@testable import fuze

final class MatchesNetworkRequestTests: XCTestCase {
    private let configurationSpy = AppConfigurationProviderSpy()
    func test_whenInstantiated_givenUpcomingCase_shouldConfigureCorrectly() {
        configurationSpy.stubbedAccessTokenResult = "u89t4ut9843ut984tu"
        let sut = MatchesNetworkRequest.upcoming(page: 3, configuration: configurationSpy)

        XCTAssertEqual(sut.parameters.keys.count, 3)
        XCTAssertEqual(sut.parameters["page"], "3")
        XCTAssertEqual(sut.parameters["per_page"], "10")
        XCTAssertEqual(sut.parameters["token"], "u89t4ut9843ut984tu")
        XCTAssertEqual(sut.path, "/csgo/matches/upcoming")
        XCTAssertEqual(sut.method, .get)
    }

    func test_whenInstantiated_givenRunningCase_shouldConfigureCorrectly() {
        configurationSpy.stubbedAccessTokenResult = "u89t4ut9843ut984tu"
        let sut = MatchesNetworkRequest.running(page: 2, configuration: configurationSpy)

        XCTAssertEqual(sut.parameters.keys.count, 3)
        XCTAssertEqual(sut.parameters["page"], "2")
        XCTAssertEqual(sut.parameters["per_page"], "10")
        XCTAssertEqual(sut.parameters["token"], "u89t4ut9843ut984tu")
        XCTAssertEqual(sut.path, "/csgo/matches/running")
        XCTAssertEqual(sut.method, .get)
    }
}
