//
//  UserViewModelTests.swift
//  BankTests
//
//  Created by Ian Fan on 2024/6/10.
//

import XCTest
@testable import Bank

final class UserViewModelTests: XCTestCase {
    var viewModel: UserViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let params = FileParams_user(fileName: "friend3", fileExt: "json")
        let key = params.cacheKey
        JsonHelper().clearJson(forKey: key)
        
        viewModel = UserViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadData() async throws {
        let params = FileParams_user(fileName: "friend3", fileExt: "json")
        
        viewModel.loadData()
        
        viewModel.successAction = {
            let objs = self.viewModel.users
            XCTAssertTrue(objs.count > 0)
        }
        viewModel.failAction = {
            XCTFail("\(#function) error")
        }
    }
}
