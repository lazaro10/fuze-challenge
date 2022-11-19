import XCTest
@testable import fuze

final class AccessTokenProviderTests: XCTestCase {
    let sut = AccessTokenProvider()
    
    func test_getAccessToken_givenPandaScoreProvider_shouldValidToken() {
        let token = sut.getAccessToken(api: .pandaScore)

        XCTAssertEqual(token.key, "token")
        XCTAssertEqual(token.value, "GvAv5qmV2djFnCh_Qtv5DGpS162Efjo7VgeQ45yNOH195DegCbQ")
    }
}
