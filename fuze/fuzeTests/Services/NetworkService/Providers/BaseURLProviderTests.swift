import XCTest
@testable import fuze

final class BaseURLProviderTests: XCTestCase {
    let sut = BaseURLProvider()
    
    func test_getUrl_givenPandaScoreProvider_shouldValidUrl() {
        let url = sut.getURL(api: .pandaScore)

        XCTAssertEqual(url.absoluteString, "https://api.pandascore.co")
    }
}
