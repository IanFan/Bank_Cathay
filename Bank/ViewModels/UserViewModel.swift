//
//  UserViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation
import UIKit

protocol UserViewModelProtocol: AnyObject {
    func updateUserUI()
}

class UserViewModel: NSObject {
    weak var delegate: UserViewModelProtocol?
    var users = [UserModel]()
    
    var successAction: (() -> Void)?
    var failAction: (() -> Void)?
    
    func loadData(isRefresh: Bool = false) {
        loadData(isRefresh: isRefresh, completion: { result in
            self.delegate?.updateUserUI()
        })
    }
    
    func loadData(isRefresh: Bool = false, completion: @escaping (Result<[UserModel], Error>) -> Void) {
        
        let fileName: String = "man"
        let fileExt = "json"
        
        let params = FileParams_user(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: UserLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.response else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                        self.failAction?()
                    }
                    return
                }
                let sortedObjs = self.sortUserObjs(objs: objs)
                DispatchQueue.main.async {
                    self.users = sortedObjs
                    completion(.success(sortedObjs))
                    self.successAction?()
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                    self.failAction?()
                }
            }
        })
    }
    
    private func sortUserObjs(objs: [UserModel]) -> [UserModel] {
//        var objs = objs
//        objs.sort {
//            return ($0.adSeqNo) < ($1.adSeqNo)
//        }
        return objs
    }
}
