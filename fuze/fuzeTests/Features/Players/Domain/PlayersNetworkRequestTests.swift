import XCTest
@testable import fuze

final class PlayersNetworkRequestTests: XCTestCase {
    private let sut = PlayersNetworkRequest(page: 3, teamId: 3943)

    func test_whenInstantiated_shouldConfigureCorrectly() {
        XCTAssertEqual(sut.parameters.keys.count, 3)
        XCTAssertEqual(sut.parameters["page"], "3")
        XCTAssertEqual(sut.parameters["per_page"], "20")
        XCTAssertEqual(sut.parameters["filter[team_id]"], "3943")
        XCTAssertEqual(sut.path, "/csgo/players")
        XCTAssertEqual(sut.method, .get)
    }
}
