//
//  AdCell.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class AdCell: UICollectionViewCell {
    static var cellID: String = "AdCell"
    
    let scale: CGFloat = UIFactory.getScale()
    var adModel: HomeAdModel?
    var imageLoader = DownloadImageViewModel()
    
    var ivAd: UIImageView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        let ivAd = UIFactory.createImage(name: "", corner: 12*scale)
        
        contentView.addSubview(ivAd)
        
        self.ivAd = ivAd
        
        ivAd.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            ivAd.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ivAd.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ivAd.widthAnchor.constraint(equalToConstant: 327*scale),
            ivAd.heightAnchor.constraint(equalToConstant: 88*scale),
        ])
    }
    
    func setupWithItem(item: HomeAdModel) {
        self.adModel = item
        
        if let ivAd = ivAd, !item.linkUrl.isEmpty {
            imageLoader.downloadImage(iv: ivAd, urlStr: item.linkUrl)
        }
    }
}
