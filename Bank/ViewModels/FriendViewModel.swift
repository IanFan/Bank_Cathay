//
//  FriendViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation
import UIKit

protocol FriendViewModelProtocol: AnyObject {
    func updateFriendUI()
}

enum RequestFriendType {
    case NoFriend
    case FriendWithMixedSource
    case FriendAndInvite
}

class FriendViewModel: NSObject {
    weak var delegate: FriendViewModelProtocol?
    var friends = [FriendModel]()
    var inviteFriends = [FriendModel]()
    
    var successAction: (() -> Void)?
    var failAction: (() -> Void)?
    
    func loadData(isRefresh: Bool = false, requestType: RequestFriendType) {
        let dispatchGroup = DispatchGroup()
        var loadError: Error?
        
        var fileNames = [String]()
        switch requestType {
        case .NoFriend:
            fileNames = ["friend4"]
        case .FriendWithMixedSource:
            fileNames = ["friend1", "friend2"]
        case .FriendAndInvite:
            fileNames = ["friend3"]
        }
        
        var tmpFriends = [FriendModel]()
        
        for fileName in fileNames {
            dispatchGroup.enter()
            loadFriendData(fileName: fileName, isRefresh: isRefresh, completion: { result in
                switch result {
                case .success(let friendResponseModel):
                    guard let objs = friendResponseModel.response, !objs.isEmpty else {
                        loadError = LoadError.loadError
                        return
                    }
                    tmpFriends.append(contentsOf: objs)
                case .failure(let error):
                    loadError = error
                }
                dispatchGroup.leave()
            })
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            if let error = loadError {
//                self.delegate?.showAmountError(error)
                self.failAction?()
            } else {
                let (sortedFriends, sortedInviteFriends) = self.sortFriendObjs(objs: tmpFriends)
                self.friends = sortedFriends
                self.inviteFriends = sortedInviteFriends
                
                self.delegate?.updateFriendUI()
                self.successAction?()
            }
        }
    }
    
    func loadFriendData(fileName: String, isRefresh: Bool = false, completion: @escaping (Result<FriendResponseModel, Error>) -> Void) {
        let fileExt = "json"
        
        let params = FileParams_friend(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: FriendLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                DispatchQueue.main.async {
                    completion(.success(resultParams))
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                }
            }
        })
    }
    
    private func sortFriendObjs(objs: [FriendModel]) -> ([FriendModel], [FriendModel]) {
        // replace repeat fid
        var dic = [String : FriendModel]()
        for obj in objs {
            if let exist = dic[obj.fid], (exist.updateDateTime ?? 0) > (obj.updateDateTime ?? 0) {
                // do nothing
            } else {
                dic[obj.fid] = obj
            }
        }
        
        // split to friends and inviteFriends
        var friends = [FriendModel]()
        var inviteFriends = [FriendModel]()
        for (_, obj) in dic {
            if obj.status == 1 || obj.status == 2 {
                friends.append(obj)
            } else if obj.status == 0 {
                inviteFriends.append(obj)
            }
        }
        
        // sort friends
        friends = friends.sorted{ $0.updateDateTime ?? 0 > $1.updateDateTime ?? 0 }
        friends = friends.sorted{ $0.isTopInt > $1.isTopInt }
        friends = friends.sorted{ $0.status > $1.status }
        
        // sort inviteFriends
        inviteFriends = inviteFriends.sorted{ $0.updateDateTime ?? 0 > $1.updateDateTime ?? 0 }
        
        return (friends, inviteFriends)
    }
}

extension FriendViewModel {
    func getCompleteFriendCount() -> Int {
        return friends.filter { $0.status == 2 }.count
    }
    
    func getFriendListCount() -> Int {
        return friends.count
    }
    
    func getInviteFriendListCount() -> Int {
        return inviteFriends.count
    }
}
