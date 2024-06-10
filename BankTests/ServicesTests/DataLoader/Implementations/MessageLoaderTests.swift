import XCTest
@testable import Bank

final class MessageLoaderTests: XCTestCase {
    var loader: MessageLoader!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
        let key = params.cacheKey
        JsonHelper().clearJson(forKey: key)
        
        loader = MessageLoader()
    }

    override func tearDownWithError() throws {
        loader = nil
        super.tearDown()
    }
    
    func testLoadDataFromCache() async throws {
        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
        
        switch try await loader.loadDataOnline(params: params) {
        case .success(let responseModel):
            switch try loader.loadDataFromCache(params: params) {
            case .success(let responseModel):
                XCTAssertNotNil(responseModel)
                XCTAssertTrue(responseModel.result?.messages?.count ?? 0 > 0)
            case .failure(let error):
                XCTFail("\(#function) error \(error)")
            }
        case .failure(let error):
            XCTFail("\(#function) error \(error)")
        }
    }
    
//    func testLoadDataLocal() throws {
//        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
//        
//        switch try loader.loadDataLocal(params: params) {
//        case .success(let responseModel):
//            XCTAssertNotNil(responseModel)
//            XCTAssertTrue(responseModel.result?.messages.count ?? 0 > 0)
//        case .failure(let error):
//            XCTFail("\(#function) error \(error)")
//        }
//    }
    
    func testLoadDataOnline() async throws {
        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
        
        switch try await loader.loadDataOnline(params: params) {
        case .success(let responseModel):
            XCTAssertNotNil(responseModel)
            XCTAssertTrue(responseModel.result?.messages?.count ?? 0 > 0)
        case .failure(let error):
            XCTFail("\(#function) error \(error)")
        }
    }

    func testPerformanceExample1() throws {
        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
        
        self.measure {
            do {
                let _ = try loader.loadDataFromCache(params: params)
            } catch {
            }
        }
    }
    
    func testPerformanceExample2() throws {
        let params = FileParams_message(fileName: "notificationList", fileExt: "json")
        
        self.measure {
            do {
                let _ = try loader.loadDataLocal(params: params)
            } catch {
            }
        }
    }
}
