import XCTest
@testable import fuze

final class FuzeImagesTests: XCTestCase {
    func test_images_givenInstantiated_shouldAllImageNamesAreCorrect() {
        XCTAssertNotNil(UIImage.placeholderCircle)
        XCTAssertNotNil(UIImage.placeholderCircleSmall)
        XCTAssertNotNil(UIImage.placeholderRounded)
    }
}
