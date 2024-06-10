//
//  NotificationCell.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class NotificationCell: UICollectionViewCell {
    static var cellID: String = "NotificationCell"
    
    let scale: CGFloat = UIFactory.getScale()
    var message: MessageModel?
    
    var vStatus: UIView!
    var lbTitle: UILabel!
    var lbTime: UILabel!
    var lbMessage: UILabel!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        let vStatus = UIFactory.createView(color: ColorEnum.localOrange1.color, corner: 6*scale)
        let lbTitle = UIFactory.createLabel(size: 18*scale, text: "", color: ColorEnum.systemGray10.color, font: .SFProTextMedium)
        let lbTime = UIFactory.createLabel(size: 14*scale, text: "", color: ColorEnum.systemGray10.color, font: .SFProTextRegular)
        let lbMessage = UIFactory.createLabel(size: 16*scale, text: "", color: ColorEnum.localBattleshipGrey.color, font: .SFProTextRegular)
        
        lbMessage.numberOfLines = 2
        
        contentView.addSubview(vStatus)
        contentView.addSubview(lbTitle)
        contentView.addSubview(lbTime)
        contentView.addSubview(lbMessage)
        
        self.vStatus = vStatus
        self.lbTitle = lbTitle
        self.lbTime = lbTime
        self.lbMessage = lbMessage
        
        let margin = 32*scale
        NSLayoutConstraint.activate([
            vStatus.trailingAnchor.constraint(equalTo: lbTitle.leadingAnchor, constant: -4*scale),
            vStatus.centerYAnchor.constraint(equalTo: lbTitle.centerYAnchor, constant: 1*scale),
            vStatus.widthAnchor.constraint(equalToConstant: 12*scale),
            vStatus.heightAnchor.constraint(equalToConstant: 12*scale),
            
            lbTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            lbTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            lbTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16*scale),
            lbTitle.heightAnchor.constraint(equalToConstant: 24*scale),
            
            lbTime.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            lbTime.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            lbTime.topAnchor.constraint(equalTo: lbTitle.bottomAnchor),
            lbTime.heightAnchor.constraint(equalToConstant: 24*scale),
            
            lbMessage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            lbMessage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            lbMessage.topAnchor.constraint(equalTo: lbTime.bottomAnchor),
            lbMessage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16*scale),
        ])
        
    }
    
    func setupWithItem(item: MessageModel) {
        self.message = item
        
        lbTitle.text = item.title
        lbTime.text = item.updateDateTime
        lbMessage.text = item.message
        vStatus.alpha = item.status ? 0 : 1.0
    }
}
