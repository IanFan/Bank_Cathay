//
//  FavoriteViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

protocol FavoriteViewModelProtocol: AnyObject {
    func updateFavoriteUI()
}

class FavoriteViewModel: NSObject {
    weak var delegate: FavoriteViewModelProtocol?
    var favorites = [FavoriteModel]()
    let scale: CGFloat = UIFactory.getScale()
    
    func loadData(isRefresh: Bool = false) {
        loadData(isRefresh: isRefresh, completion: { result in
            self.delegate?.updateFavoriteUI()
        })
    }
    
    func loadData(isRefresh: Bool = false, completion: @escaping (Result<[FavoriteModel], Error>) -> Void) {
        
        var fileName: String
        if isRefresh {
            fileName = "favoriteList"
        } else {
            fileName = "emptyFavoriteList"
        }
        let fileExt = "json"
        
        let params = FileParams_favorite(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: FavoriteLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.favoriteList else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                let sortedObjs = self.sortFavoriteObjs(objs: objs)
                DispatchQueue.main.async {
                    self.favorites = sortedObjs
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
    
    private func sortFavoriteObjs(objs: [FavoriteModel]) -> [FavoriteModel] {
//        var objs = objs
//        objs.sort {
//            return ($0.adSeqNo) < ($1.adSeqNo)
//        }
        return objs
    }
}

extension FavoriteViewModel: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = favorites[indexPath.row]
        let item = HomeFavoriteModel(transType: obj.transType, title: obj.nickname)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.cellID, for: indexPath) as! FavoriteCell
        cell.setupWithItem(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
