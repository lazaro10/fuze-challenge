import XCTest
@testable import fuze

final class MatchesConverterTests: XCTestCase {
    let sut = MatchesConverter()

    func test_conver_shouldConverterInViewModel() {
        let viewModel: MatchViewModel = sut.convert(.fixture())

        XCTAssertEqual(viewModel.confrontationViewModel.rightOpponentId, 4543)
        XCTAssertEqual(viewModel.confrontationViewModel.leftOpponentId, 3454)
        XCTAssertEqual(viewModel.confrontationViewModel.rightOpponentName, "SKADE X")
        XCTAssertEqual(viewModel.confrontationViewModel.leftOpponentName, "180mgkoffein")
        XCTAssertEqual(viewModel.confrontationViewModel.rightOpponentImageURL, nil)
        XCTAssertEqual(viewModel.confrontationViewModel.leftOpponentImageURL, nil)
        XCTAssertEqual(viewModel.leagueSerie, "Closed Qualifier | Season 6 2022")
        XCTAssertEqual(viewModel.matchTime, "Sun 06:30")
        XCTAssertEqual(viewModel.matchTimeViewColor, .tertiaryGrey)
        XCTAssertEqual(viewModel.id, 20)
        XCTAssertEqual(viewModel.leagueImageURL, nil)
    }

    func test_convertList_shouldConverterInViewModels() {
        let viewModels = sut.convert([.fixture()])

        XCTAssertEqual(viewModels.count, 1)
    }
}
