import XCTest
@testable import fuze

final class MatchesConverterTests: XCTestCase {
    let sut = MatchesConverter()

    func test_convert_shouldConverterInViewModel() {
        let viewModels = sut.convert([.fixture()])

        XCTAssertEqual(viewModels.count, 1)
    }
}
