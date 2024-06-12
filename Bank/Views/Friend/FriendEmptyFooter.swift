//
//  FriendFooter.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation
import UIKit

protocol FriendEmptybFooterDelegate: AnyObject {
}

class FriendEmptyFooter: UICollectionReusableView {
    static let headerID = "FriendEmptyFooter"

    weak var delegate: FriendEmptybFooterDelegate?
    let scale: CGFloat = UIFactory.getScale()
    
    var ivEmpty: UIImageView!
    var lbTitle: UILabel!
    var lbDes: UILabel!
    var vAddFriend: UIView!
    var btnAddFriend: UIButton!
    var ivAddFriend: UIImageView!
    var textSetKokoid: UITextView!
    var btnSetKokoid: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = ColorFactory.white2
        
        let ivEmpty = UIFactory.createImage(name: "imgFriendsEmpty")
        let lbTitle = UIFactory.createLabel(size: 21*scale, text: "就從加好友開始吧：）".localized(), color: ColorFactory.greyishBrown, font: .PingFangTCMedium, textAlignment: .center)
        let lbDes = UIFactory.createLabel(size: 14*scale, text: "與好友們一起用 KOKO 聊起來！\n還能互相收付款、發紅包喔：）".localized(), color: ColorFactory.greyishBrown, font: .PingFangTCMedium, textAlignment: .center)
        let vAddFriend = UIFactory.createView(color: .clear)
        let btnAddFriend = UIFactory.createTextButton(size: 16*scale, text: "加好友".localized(), textColor: ColorFactory.white3, bgColor: .clear)
        let ivAddFriend = UIFactory.createImage(name: "icAddFriendWhite")
        let textSetKokoid = UIFactory.createTextView(size: 13*scale, text: "", color: .clear, font: .PingFangTCRegular)
        let btnSetKokoid = UIFactory.createImageButton(name: "")
        
        self.ivEmpty = ivEmpty
        self.lbTitle = lbTitle
        self.lbDes = lbDes
        self.vAddFriend = vAddFriend
        self.btnAddFriend = btnAddFriend
        self.ivAddFriend = ivAddFriend
        self.textSetKokoid = textSetKokoid
        self.btnSetKokoid = btnSetKokoid
        
        addSubview(ivEmpty)
        addSubview(lbTitle)
        addSubview(lbDes)
        addSubview(vAddFriend)
        addSubview(btnAddFriend)
        addSubview(ivAddFriend)
        addSubview(textSetKokoid)
        addSubview(btnSetKokoid)
        
        lbDes.numberOfLines = 2
        UIFactory.addGradient(view: vAddFriend, colorStart: ColorFactory.frogGreen, colorEnd: ColorFactory.booger, width: 192*scale, height: 40*scale, corner: 20*scale, isLeftToRight: true)
        UIFactory.addShadow(view: vAddFriend, width: 0, height: 4*scale, shadowOpacity: 0.4, shadowColor: ColorFactory.appleGreen)
        btnSetKokoid.addTarget(self, action: #selector(btnSetKokoidTapped), for: .touchUpInside)
        textSetKokoid.attributedText = getSetKokoidLinkAttStr()
        
        NSLayoutConstraint.activate([
            ivEmpty.topAnchor.constraint(equalTo: topAnchor, constant: 30*scale),
            ivEmpty.centerXAnchor.constraint(equalTo: centerXAnchor),
            ivEmpty.widthAnchor.constraint(equalToConstant: 245*scale),
            ivEmpty.heightAnchor.constraint(equalToConstant: 172*scale),
            
            lbTitle.topAnchor.constraint(equalTo: ivEmpty.bottomAnchor, constant: 41*scale),
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44*scale),
            lbTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44*scale),
            lbTitle.heightAnchor.constraint(equalToConstant: 29*scale),
            
            lbDes.topAnchor.constraint(equalTo: lbTitle.bottomAnchor, constant: 8*scale),
            lbDes.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 44*scale),
            lbDes.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -44*scale),
            
            vAddFriend.topAnchor.constraint(equalTo: lbDes.bottomAnchor, constant: 25*scale),
            vAddFriend.centerXAnchor.constraint(equalTo: centerXAnchor),
            vAddFriend.widthAnchor.constraint(equalToConstant: 192*scale),
            vAddFriend.heightAnchor.constraint(equalToConstant: 40*scale),
            
            btnAddFriend.topAnchor.constraint(equalTo: vAddFriend.topAnchor),
            btnAddFriend.bottomAnchor.constraint(equalTo: vAddFriend.bottomAnchor),
            btnAddFriend.leadingAnchor.constraint(equalTo: vAddFriend.leadingAnchor),
            btnAddFriend.trailingAnchor.constraint(equalTo: vAddFriend.trailingAnchor),
            
            ivAddFriend.centerYAnchor.constraint(equalTo: vAddFriend.centerYAnchor),
            ivAddFriend.trailingAnchor.constraint(equalTo: vAddFriend.trailingAnchor, constant: -8*scale),
            ivAddFriend.widthAnchor.constraint(equalToConstant: 24*scale),
            ivAddFriend.heightAnchor.constraint(equalToConstant: 24*scale),
            
            textSetKokoid.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5*scale),
            textSetKokoid.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            btnSetKokoid.leadingAnchor.constraint(equalTo: textSetKokoid.leadingAnchor),
            btnSetKokoid.trailingAnchor.constraint(equalTo: textSetKokoid.trailingAnchor),
            btnSetKokoid.topAnchor.constraint(equalTo: textSetKokoid.topAnchor),
            btnSetKokoid.bottomAnchor.constraint(equalTo: textSetKokoid.bottomAnchor),
        ])
    }
    
    private func getSetKokoidLinkAttStr() -> NSAttributedString {
        let str1 = "幫助好友更快找到你？".localized()
        let str2 = "設定 KOKO ID".localized()
        
        let fullString = "\(str1)\(str2)"
        let attributedString = NSMutableAttributedString(string: fullString)

        let fullRange = (fullString as NSString).range(of: fullString)
        attributedString.addAttribute(.font, value: UIFactory.getFont(font: FontEnum.PingFangTCRegular, size: 13*scale), range: fullRange)
        
        let blackRange = (fullString as NSString).range(of: str1)
        attributedString.addAttribute(.foregroundColor, value: ColorFactory.brownGrey, range: blackRange)

        let redRange = (fullString as NSString).range(of: str2)
        attributedString.addAttribute(.foregroundColor, value: ColorFactory.hotpink, range: redRange)
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: redRange)
        return attributedString
    }
    
    @objc func btnSetKokoidTapped() {
    }
}
