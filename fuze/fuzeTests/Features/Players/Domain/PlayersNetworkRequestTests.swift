import XCTest
@testable import fuze

final class PlayersNetworkRequestTests: XCTestCase {
    let configurationSpy = AppConfigurationProviderSpy()
    private lazy var sut = PlayersNetworkRequest(page: 3, teamId: 3943, configuration: configurationSpy)

    func test_whenInstantiated_shouldConfigureCorrectly() {
        configurationSpy.stubbedAccessTokenResult = "u89t4ut9843ut984tu"

        XCTAssertEqual(sut.parameters.keys.count, 4)
        XCTAssertEqual(sut.parameters["page"], "3")
        XCTAssertEqual(sut.parameters["per_page"], "20")
        XCTAssertEqual(sut.parameters["filter[team_id]"], "3943")
        XCTAssertEqual(sut.parameters["token"], "u89t4ut9843ut984tu")
        XCTAssertEqual(sut.path, "/csgo/players")
        XCTAssertEqual(sut.method, .get)
    }
}
