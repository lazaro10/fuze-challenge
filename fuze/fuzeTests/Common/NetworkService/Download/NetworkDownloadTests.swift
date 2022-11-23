import Foundation
import XCTest
@testable import fuze

final class NetworkDownloadTests: XCTestCase {
    let sessionSpy = NetworkProviderSpy()
    let cacheManagerSpy = CacheManagerSpy()
 
    lazy var sut = NetworkDownload(
        session: sessionSpy,
        cacheManager: cacheManagerSpy
    )
    
//    func test_loadData_givenDownloadData_shouldCopyItem() throws {
//        let url = try XCTUnwrap(URL(string: "https://moises.ai/logo.pgn"))
//
//        sessionSpy.stubbedDownloadTaskCompletionHandlerResult = (url, nil, nil)
//        
//        let file = try XCTUnwrap(URL(string: "////Devices//data/Containers/Data/tmp/logo.pgn"))
//        fileManagerProvdiderSpy.stubbedAppendingPathComponentResult = file
//
//        sut.loadData(url: url) { _ in }
//        
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedAppendingPathComponentCount, 1)
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedAppendingPathComponentParameterPathComponent, "logo.pgn")
//        XCTAssertEqual(sessionSpy.invokedDownloadTaskCount, 1)
//        XCTAssertEqual(sessionSpy.invokedDataTaskParameterURL?.absoluteString, "https://moises.ai/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemParameterSrcURL?.absoluteString, "https://moises.ai/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemParameterDstURL?.absoluteString, "////Devices//data/Containers/Data/tmp/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemCount, 1)
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedRemoveItemCount, 0)
//    }
//    
//    func test_loadData_givenDownloadData_givenExistsFile_shouldRemoveItem() throws {
//        let url = try XCTUnwrap(URL(string: "https://moises.ai/logo.pgn"))
//
//        sessionSpy.stubbedDownloadTaskCompletionHandlerResult = (url, nil, nil)
//        
//        let file = try XCTUnwrap(URL(string: "////Devices//data/Containers/Data/tmp/logo.pgn"))
//        fileManagerProvdiderSpy.stubbedAppendingPathComponentResult = file
//        fileManagerProvdiderSpy.stubbedFileExistsResult = true
//        sut.loadData(url: url) { _ in }
//        
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedAppendingPathComponentCount, 1)
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedAppendingPathComponentParameterPathComponent, "logo.pgn")
//        XCTAssertEqual(sessionSpy.invokedDownloadTaskCount, 1)
//        XCTAssertEqual(sessionSpy.invokedDataTaskParameterURL?.absoluteString, "https://moises.ai/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemParameterSrcURL?.absoluteString, "https://moises.ai/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemParameterDstURL?.absoluteString, "////Devices//data/Containers/Data/tmp/logo.pgn")
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedCopyItemCount, 1)
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedRemoveItemCount, 1)
//        XCTAssertEqual(fileManagerProvdiderSpy.invokedRemoveItemParameterURL?.absoluteString, "////Devices//data/Containers/Data/tmp/logo.pgn")
//    }
}
