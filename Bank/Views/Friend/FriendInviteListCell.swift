//
//  InviteFriendCell.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation
import UIKit

class FriendInviteListCell: UICollectionViewCell {
    static var cellID: String = "FriendInviteListCell"
    
    let scale: CGFloat = UIFactory.getScale()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        
    }
    
//    func setupWithItem(item: MessageModel) {
//        self.message = item
//        
//        lbTitle.text = item.title
//        lbTime.text = item.updateDateTime
//        lbMessage.text = item.message
//        vStatus.alpha = item.status ? 0 : 1.0
//    }
}
