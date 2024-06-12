//
//  FriendViewModelTests.swift
//  BankTests
//
//  Created by Ian Fan on 2024/6/10.
//

import XCTest
@testable import Bank

final class FriendViewModelTests: XCTestCase {
    var viewModel: FriendViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        
        let params = FileParams_friend(fileName: "friend3", fileExt: "json")
        let key = params.cacheKey
        JsonHelper().clearJson(forKey: key)
        
        viewModel = FriendViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadData() async throws {
        let params = FileParams_friend(fileName: "friend3", fileExt: "json")
        
        viewModel.loadData(requestType: .FriendWithMixedSource)
        
        viewModel.successAction = {
            guard let viewModel = self.viewModel else {
                XCTFail("\(#function) error")
                return
            }
            let friends = viewModel.inviteFriends
            let inviteFriends = viewModel.inviteFriends
            XCTAssertTrue(friends.count > 0)
            XCTAssertTrue(inviteFriends.count > 0)
        }
        viewModel.failAction = {
            XCTFail("\(#function) error")
        }
    }
}
