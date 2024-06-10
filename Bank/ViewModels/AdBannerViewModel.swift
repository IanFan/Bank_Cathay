//
//  AdBannerViewModel.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

protocol AdBannerViewModelProtocol: AnyObject {
    func updateAdBannerUI()
}

class AdBannerViewModel: NSObject {
    weak var delegate: AdBannerViewModelProtocol?
    var adBanners = [AdBannerModel]()
    
    func loadData(isRefresh: Bool = false) {
        loadData(isRefresh: isRefresh, completion: { result in
            self.delegate?.updateAdBannerUI()
        })
    }
    
    func loadData(isRefresh: Bool = false, completion: @escaping (Result<[AdBannerModel], Error>) -> Void) {
        
        var fileName: String
        if isRefresh {
            fileName = "banner"
        } else {
            fileName = "banner"
        }
        let fileExt = "json"
        
        let params = FileParams_adBanner(fileName: fileName, fileExt: fileExt)
        let loader = GenericSingleDataLoader(dataLoader: AdBannerLoader())
        loader.loadData(params: params, completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let resultParams):
                guard let objs = resultParams.result?.bannerList else {
                    DispatchQueue.main.async {
                        completion(.failure(LoadError.emptyDataError))
                    }
                    return
                }
                let sortedObjs = self.sortAdBannerObjs(objs: objs)
                DispatchQueue.main.async {
                    self.adBanners = sortedObjs
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
    
    private func sortAdBannerObjs(objs: [AdBannerModel]) -> [AdBannerModel] {
        var objs = objs
        objs.sort {
            return ($0.adSeqNo) < ($1.adSeqNo)
        }
        return objs
    }
}

extension AdBannerViewModel: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return adBanners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let obj = adBanners[indexPath.row]
        let item = HomeAdModel(adSeqNo: obj.adSeqNo, linkUrl: obj.linkUrl)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AdCell.cellID, for: indexPath) as! AdCell
        cell.setupWithItem(item: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }
}
