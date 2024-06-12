//
//  FriendListCell.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/12.
//

import Foundation
import UIKit

class FriendListCell: UICollectionViewCell {
    static var cellID: String = "FriendListCell"
    
    let scale: CGFloat = UIFactory.getScale()
    var item: FriendListModel?
    
    var ivStar: UIImageView!
    var ivAvatar: UIImageView!
    var lbName: UILabel!
    var btnTransfer: UIButton!
    var btnInviting: UIButton!
    var btnMore: UIButton!
//    var ivMore: UIImageView!
    
    var btnTransferTrailingConstraint: NSLayoutConstraint!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = ColorFactory.white3
        
        let ivStar = UIFactory.createImage(name: "icFriendsStar")
        let ivAvatar = UIFactory.createImage(name: "imgFriendsList")
        let lbName = UIFactory.createLabel(size: 16*scale, text: "", color: ColorFactory.greyishBrown, font: FontEnum.PingFangTCRegular)
        let btnTransfer = UIFactory.createTextButton(size: 14*scale, text: "轉帳".localized(), textColor: ColorFactory.hotpink, bgColor: .clear, font: FontEnum.PingFangTCMedium, corner: 2*scale)
        let btnInviting = UIFactory.createTextButton(size: 14*scale, text: "邀請中".localized(), textColor: ColorFactory.brownGrey, bgColor: .clear, font: FontEnum.PingFangTCMedium, corner: 2*scale)
        let btnMore = UIFactory.createImageButton(name: "icFriendsMore")
        
        self.ivStar = ivStar
        self.ivAvatar = ivAvatar
        self.lbName = lbName
        self.btnTransfer = btnTransfer
        self.btnInviting = btnInviting
        self.btnMore = btnMore
        
        contentView.addSubview(ivStar)
        contentView.addSubview(ivAvatar)
        contentView.addSubview(lbName)
        contentView.addSubview(btnTransfer)
        contentView.addSubview(btnInviting)
        contentView.addSubview(btnMore)
        
        btnTransfer.layer.borderWidth = 1.2*scale
        btnTransfer.layer.borderColor = ColorFactory.hotpink.cgColor
        
        btnInviting.layer.borderWidth = 1.2*scale
        btnInviting.layer.borderColor = ColorFactory.brownGrey.cgColor
        
        if let imageView = btnMore.subviews.compactMap({ $0 as? UIImageView }).first {
            imageView.contentMode = .scaleAspectFit
        }
        
        btnTransfer.addTarget(self, action: #selector(btnTransferTapped), for: .touchUpInside)
        btnMore.addTarget(self, action: #selector(btnMoreTapped), for: .touchUpInside)
        btnInviting.addTarget(self, action: #selector(btnInvitingTapped), for: .touchUpInside)
        
        let margin = 20*scale
        let btnTransferTrailingConstraint = btnTransfer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-53*scale)
        self.btnTransferTrailingConstraint = btnTransferTrailingConstraint
        
        NSLayoutConstraint.activate([
            ivStar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin+10*scale),
            ivStar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ivStar.widthAnchor.constraint(equalToConstant: 14*scale),
            ivStar.heightAnchor.constraint(equalToConstant: 14*scale),
            
            ivAvatar.leadingAnchor.constraint(equalTo: ivStar.trailingAnchor, constant: 6*scale),
            ivAvatar.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ivAvatar.widthAnchor.constraint(equalToConstant: 40*scale),
            ivAvatar.heightAnchor.constraint(equalToConstant: 40*scale),
            
            lbName.leadingAnchor.constraint(equalTo: ivAvatar.trailingAnchor, constant: 15*scale),
            lbName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            lbName.trailingAnchor.constraint(equalTo: btnTransfer.leadingAnchor, constant: -6*scale),
            
            btnTransferTrailingConstraint,
            btnTransfer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            btnTransfer.widthAnchor.constraint(equalToConstant: 47*scale),
            btnTransfer.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnInviting.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            btnInviting.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            btnInviting.widthAnchor.constraint(equalToConstant: 60*scale),
            btnInviting.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnMore.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin-10*scale),
            btnMore.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            btnMore.widthAnchor.constraint(equalToConstant: 18*scale),
            btnMore.heightAnchor.constraint(equalToConstant: 24*scale),
        ])
        btnInviting.alpha = 0
    }
    
    func setupWithItem(item: FriendListModel) {
        self.item = item
        
        lbName?.text = item.name
        
        ivStar?.alpha = item.isTopInt == 1 ? 1.0 : 0.0
        
        let margin = 20*scale
        switch item.status {
        case 2:
            btnTransferTrailingConstraint.constant = -margin-70*scale
            btnInviting.alpha = 1
            btnMore.alpha = 0
        default:
            btnTransferTrailingConstraint.constant = -margin-53*scale
            btnInviting.alpha = 0
            btnMore.alpha = 1
        }
    }
    
    @objc func btnTransferTapped() {
        
    }
    
    @objc func btnMoreTapped() {
        
    }
    
    @objc func btnInvitingTapped() {
        
    }
}
