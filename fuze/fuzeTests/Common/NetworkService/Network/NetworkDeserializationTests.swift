import XCTest
@testable import fuze

final class NetworkDeserializationTests: XCTestCase {
    let sut = NetworkDeserialization()
    
    func test_decode_givenAValidData_shouldDecodeWithSuccess() throws {
        let json = """
        {
            "firstParam": "fuze",
            "secondParam": 456
        }
        """
        
        let object: ResponseModel = try XCTUnwrap(sut.decode(data: Data(json.utf8)))
        
        XCTAssertEqual(object.firstParam, "fuze")
        XCTAssertEqual(object.secondParam, 456)
    }
    
    func test_decode_givenAInvalidData_shouldThrowInvalidDecode()  {
        let json = """
        {
            "firstParam": 2.5,
            "secondParam": 0
        }
        """

        do {
            let _: ResponseModel = try sut.decode(data: Data(json.utf8))
        } catch {
            XCTAssertEqual(error as? NetworkDeserializationError, NetworkDeserializationError.invalidDecode)
        }
    }
}
