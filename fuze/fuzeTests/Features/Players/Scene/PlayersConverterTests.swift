import XCTest
@testable import fuze

final class PlayersConverterTests: XCTestCase {
    let sut = PlayersConverter()

    func test_conver_shouldConverterInViewModel() {
        let viewModels = sut.convert([.fixture()], alignment: .right)
        XCTAssertEqual(viewModels.count, 1)

        let viewModel = viewModels[0]
        XCTAssertEqual(viewModel, .fixture())
    }
}
