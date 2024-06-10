//
//  FavoriteCell.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class FavoriteCell: UICollectionViewCell {
    static var cellID: String = "FavoriteCell"
    
    let scale: CGFloat = UIFactory.getScale()
    var favorite: HomeFavoriteModel?
    
    var ivIcon: UIImageView!
    var lbTitle: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        let ivIcon = UIFactory.createImage(name: "")
        let lbTitle = UIFactory.createLabel(size: 12*scale, text: "", color: ColorEnum.systemGray6.color, font: .SFProTextRegular)
        
        contentView.addSubview(ivIcon)
        contentView.addSubview(lbTitle)
        
        self.ivIcon = ivIcon
        self.lbTitle = lbTitle
        
        lbTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([
            ivIcon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4*scale),
            ivIcon.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            ivIcon.widthAnchor.constraint(equalToConstant: 56*scale),
            ivIcon.heightAnchor.constraint(equalToConstant: 56*scale),
            
            lbTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lbTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lbTitle.topAnchor.constraint(equalTo: ivIcon.bottomAnchor, constant: 1*scale),
        ])
        
    }
    
    func setupWithItem(item: HomeFavoriteModel) {
        self.favorite = item
        
        ivIcon.image = UIImage(named: item.imageName)
        lbTitle.text = item.title.localized()
    }
}
