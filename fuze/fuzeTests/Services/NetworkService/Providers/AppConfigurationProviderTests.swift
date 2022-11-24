import XCTest
@testable import fuze

final class AppConfigurationProviderTests: XCTestCase {
    let sut = AppConfigurationProvider()

    func test_baseURL_givenPandaScoreProvider_shouldValidURBL() {
        let url = sut.baseURL(.pandaScore)

        XCTAssertEqual(url.absoluteString, "https://api.pandascore.co")
    }

    func test_accessToken_givenPandaScoreProvider_shouldValidURBL() {
        let token = sut.accessToken(.pandaScore)

        XCTAssertEqual(token, "GvAv5qmV2djFnCh_Qtv5DGpS162Efjo7VgeQ45yNOH195DegCbQ")
    }
}

