//
//  FavoriteParserTests.swift
//  BankTests
//
//  Created by Ian Fan on 2024/6/8.
//

import XCTest
@testable import Bank

final class FavoriteLoaderTests: XCTestCase {
    var loader: FavoriteLoader!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
        let key = params.cacheKey
        JsonHelper().clearJson(forKey: key)
        
        loader = FavoriteLoader()
    }

    override func tearDownWithError() throws {
        loader = nil
        super.tearDown()
    }
    
    func testLoadDataFromCache() async throws {
        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
        
        switch try await loader.loadDataOnline(params: params) {
        case .success(let responseModel):
            switch try loader.loadDataFromCache(params: params) {
            case .success(let responseModel):
                XCTAssertNotNil(responseModel)
                XCTAssertTrue(responseModel.result?.favoriteList?.count ?? 0 > 0)
            case .failure(let error):
                XCTFail("\(#function) error \(error)")
            }
        case .failure(let error):
            XCTFail("\(#function) error \(error)")
        }
    }
    
//    func testLoadDataLocal() throws {
//        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
//        
//        switch try loader.loadDataLocal(params: params) {
//        case .success(let responseModel):
//            XCTAssertNotNil(responseModel)
//            XCTAssertTrue(responseModel.result?.favoriteList?.count ?? 0 > 0)
//        case .failure(let error):
//            XCTFail("\(#function) error \(error)")
//        }
//    }
    
    func testLoadDataOnline() async throws {
        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
        
        switch try await loader.loadDataOnline(params: params) {
        case .success(let responseModel):
            XCTAssertNotNil(responseModel)
            XCTAssertTrue(responseModel.result?.favoriteList?.count ?? 0 > 0)
        case .failure(let error):
            XCTFail("\(#function) error \(error)")
        }
    }

    func testPerformanceExample1() throws {
        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
        
        self.measure {
            do {
                let _ = try loader.loadDataFromCache(params: params)
            } catch {
            }
        }
    }
    
    func testPerformanceExample2() throws {
        let params = FileParams_favorite(fileName: "favoriteList", fileExt: "json")
        
        self.measure {
            do {
                let _ = try loader.loadDataLocal(params: params)
            } catch {
            }
        }
    }
}

