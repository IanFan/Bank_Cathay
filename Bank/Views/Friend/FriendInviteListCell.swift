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
    var item: FriendListModel?
    
    var card: UIView!
    var ivAvatar: UIImageView!
    var lbName: UILabel!
    var lbDes: UILabel!
    var btnAccept: UIButton!
    var btnDeny: UIButton!
    var restCard: UIView!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = ColorFactory.white2
        
        let restCard = UIFactory.createView(color: ColorFactory.white3, corner: 6*scale)
        let card = UIFactory.createView(color: ColorFactory.white3, corner: 6*scale)
        let ivAvatar = UIFactory.createImage(name: "imgFriendsList", corner: 20*scale)
        let lbName = UIFactory.createLabel(size: 16*scale, text: "", color: ColorFactory.greyishBrown, font: .PingFangTCRegular)
        let lbDes = UIFactory.createLabel(size: 13*scale, text: "邀請你成為好友：）".localized(), color: ColorFactory.brownGrey, font: .PingFangTCRegular)
        let btnAccept = UIFactory.createImageButton(name: "btnFriendsAgree")
        let btnDeny = UIFactory.createImageButton(name: "btnFriendsDelet")
        
        self.restCard = restCard
        self.card = card
        self.ivAvatar = ivAvatar
        self.lbName = lbName
        self.lbDes = lbDes
        self.btnAccept = btnAccept
        self.btnDeny = btnDeny
        
        contentView.addSubview(restCard)
        contentView.addSubview(card)
        card.addSubview(ivAvatar)
        card.addSubview(lbName)
        card.addSubview(lbDes)
        card.addSubview(btnAccept)
        card.addSubview(btnDeny)
        
        UIFactory.addShadow(view: restCard, width: 0, height: 2*scale, shadowOpacity: 0.1, shadowRadius: 2*scale, shadowColor: .black)
        UIFactory.addShadow(view: card, width: 0, height: 2*scale, shadowOpacity: 0.1, shadowRadius: 2*scale, shadowColor: .black)
        
        btnAccept.addTarget(self, action: #selector(btnAcceptTapped), for: .touchUpInside)
        btnDeny.addTarget(self, action: #selector(btnDenyTapped), for: .touchUpInside)
        
        let margin = 30*scale
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5*scale),
            card.heightAnchor.constraint(equalToConstant: 70*scale),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -margin),
            
            restCard.topAnchor.constraint(equalTo: card.topAnchor, constant: 10*scale),
            restCard.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: 10*scale),
            restCard.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 10*scale),
            restCard.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -10*scale),
            
            ivAvatar.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            ivAvatar.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 15*scale),
            ivAvatar.widthAnchor.constraint(equalToConstant: 40*scale),
            ivAvatar.heightAnchor.constraint(equalToConstant: 40*scale),
            
            lbName.leadingAnchor.constraint(equalTo: ivAvatar.trailingAnchor, constant: 15*scale),
            lbName.topAnchor.constraint(equalTo: ivAvatar.topAnchor),
            lbName.trailingAnchor.constraint(equalTo: btnAccept.leadingAnchor, constant: -15*scale),
            
            lbDes.leadingAnchor.constraint(equalTo: ivAvatar.trailingAnchor, constant: 15*scale),
            lbDes.bottomAnchor.constraint(equalTo: ivAvatar.bottomAnchor),
            lbDes.trailingAnchor.constraint(equalTo: btnAccept.leadingAnchor, constant: -15*scale),
            
            btnAccept.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            btnAccept.trailingAnchor.constraint(equalTo: btnDeny.leadingAnchor, constant: -15*scale),
            btnAccept.widthAnchor.constraint(equalToConstant: 30*scale),
            btnAccept.heightAnchor.constraint(equalToConstant: 30*scale),
            
            btnDeny.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            btnDeny.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -15*scale),
            btnDeny.widthAnchor.constraint(equalToConstant: 30*scale),
            btnDeny.heightAnchor.constraint(equalToConstant: 30*scale),
        ])
    }
    
    func setupWithItem(item: FriendListModel, isSpread: Bool) {
        self.item = item
        
        lbName?.text = item.name
        
        if isSpread {
            restCard?.alpha = 0
        } else {
            restCard?.alpha = 1
        }
    }
    
    @objc func btnAcceptTapped() {
        
    }
    
    @objc func btnDenyTapped() {
        
    }
}
