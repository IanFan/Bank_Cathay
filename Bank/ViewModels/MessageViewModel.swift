//
//  MessageViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

protocol MessageViewModelProtocol: AnyObject {
    func updateMessageUI()
}

class MessageViewModel: NSObject {
    weak var delegate: MessageViewModelProtocol?
    var messages = [MessageModel]()
    let scale: CGFloat = UIFactory.getScale()
    
    func loadData(isRefresh: Bool = false) {
        loadData(isRefresh: isRefresh, completion: { result in
            self.delegate?.updateMessageUI()
        })
    }
    
    func loadData(isRefresh: Bool = false, completion: @escaping (Result<[MessageModel], Error>) -> Void) {
        
        var fileName: String
        if isRefresh {
            fileName = "notificationList"
        } else {
            fileName = "emptyNotificationList"
        }
        let fileExt = "json"
        
        let params = FileParams_message(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: MessageLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.messages else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                let sortedObjs = self.sortMessageObjs(objs: objs)
                DispatchQueue.main.async {
                    self.messages = sortedObjs
                    completion(.success(sortedObjs))
                }
            case .failure(let error):
                print("load error: \(error)")
                DispatchQueue.main.async {
                    completion(.failure(LoadError.loadError))
                }
            }
        })
    }
    
    private func sortMessageObjs(objs: [MessageModel]) -> [MessageModel] {
        var objs = objs
        objs.sort {
            return ($0.updateDateTimeInterval ?? 0) > ($1.updateDateTimeInterval ?? 0)
        }
        return objs
    }
}

extension MessageViewModel: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = messages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NotificationCell.cellID, for: indexPath) as! NotificationCell
        cell.setupWithItem(item: obj)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectSectionIndex = indexPath.section
        let selectIndex = indexPath.item
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? NotificationCell, let obj: MessageModel = cell.message else {
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}

extension MessageViewModel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: 128 * scale)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

