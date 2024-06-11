//
//  UserHeader.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation
import UIKit

protocol FriendUserHeaderDelegate: AnyObject {
//    func gotoThemeList(categoryObj: CategoryObject)
}

class FriendUserHeader: UICollectionReusableView {
    static let headerID = "FriendUserHeader"

    weak var delegate: FriendUserHeaderDelegate?
    let scale: CGFloat = UIFactory.getScale()
    
    var item: UserModel?
    var ivATM: UIImageView!
    var btnATM: UIButton!
    var ivTransfer: UIImageView!
    var btnTransfer: UIButton!
    var ivScan: UIImageView!
    var btnScan: UIButton!
    var lbUserName: UILabel!
    var lbKokoid: UILabel!
    var ivKoko: UIImageView!
    var ivKokoBadge: UIView!
    var btnAvatar: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let ivATM = UIFactory.createImage(name: "icNavPinkWithdraw")
        let btnATM = UIFactory.createImageButton(name: "")
        let ivTransfer = UIFactory.createImage(name: "icNavPinkTransfer")
        let btnTransfer = UIFactory.createImageButton(name: "")
        let ivScan = UIFactory.createImage(name: "icNavPinkScan")
        let btnScan = UIFactory.createImageButton(name: "")
        let lbUserName = UIFactory.createLabel(size: 17*scale, text: "", color: ColorEnum.greyishBrown.color, font: .PingFangTCMedium)
        let lbKokoid = UIFactory.createLabel(size: 13*scale, text: "設定 KOKO ID".localized(), color: ColorEnum.greyishBrown.color, font: .PingFangTCMedium)
        let ivKoko = UIFactory.createImage(name: "icInfoBackDeepGray")
        let ivKokoBadge = UIFactory.createView(color: ColorEnum.hotpink.color, corner: 5*scale)
        let btnAvatar = UIFactory.createImageButton(name: "imgFriendsFemaleDefault", corner: 27*scale)
        
        self.ivATM = ivATM
        self.btnATM = btnATM
        self.ivTransfer = ivTransfer
        self.btnTransfer = btnTransfer
        self.ivScan = ivScan
        self.btnScan = btnScan
        self.lbUserName = lbUserName
        self.lbKokoid = lbKokoid
        self.ivKoko = ivKoko
        self.ivKokoBadge = ivKokoBadge
        self.btnAvatar = btnAvatar
        
        addSubview(ivATM)
        addSubview(btnATM)
        addSubview(ivTransfer)
        addSubview(btnTransfer)
        addSubview(ivScan)
        addSubview(btnScan)
        addSubview(lbUserName)
        addSubview(lbKokoid)
        addSubview(ivKoko)
        addSubview(ivKokoBadge)
        addSubview(btnAvatar)
        
        NSLayoutConstraint.activate([
            ivATM.topAnchor.constraint(equalTo: topAnchor, constant: 12*scale),
            ivATM.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20*scale),
            ivATM.widthAnchor.constraint(equalToConstant: 24*scale),
            ivATM.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnATM.centerYAnchor.constraint(equalTo: ivATM.centerYAnchor),
            btnATM.centerXAnchor.constraint(equalTo: ivATM.centerXAnchor),
            btnATM.widthAnchor.constraint(equalToConstant: 48*scale),
            btnATM.heightAnchor.constraint(equalToConstant: 48*scale),
            
            ivTransfer.topAnchor.constraint(equalTo: topAnchor, constant: 12*scale),
            ivTransfer.leadingAnchor.constraint(equalTo: ivATM.trailingAnchor, constant: 24.3*scale),
            ivTransfer.widthAnchor.constraint(equalToConstant: 24*scale),
            ivTransfer.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnTransfer.centerYAnchor.constraint(equalTo: ivTransfer.centerYAnchor),
            btnTransfer.centerXAnchor.constraint(equalTo: ivTransfer.centerXAnchor),
            btnTransfer.widthAnchor.constraint(equalToConstant: 48*scale),
            btnTransfer.heightAnchor.constraint(equalToConstant: 48*scale),
            
            ivScan.topAnchor.constraint(equalTo: topAnchor, constant: 12*scale),
            ivScan.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20*scale),
            ivScan.widthAnchor.constraint(equalToConstant: 24*scale),
            ivScan.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnScan.centerYAnchor.constraint(equalTo: ivScan.centerYAnchor),
            btnScan.centerXAnchor.constraint(equalTo: ivScan.centerXAnchor),
            btnScan.widthAnchor.constraint(equalToConstant: 48*scale),
            btnScan.heightAnchor.constraint(equalToConstant: 48*scale),
            
            lbUserName.topAnchor.constraint(equalTo: ivATM.bottomAnchor, constant: 35*scale),
            lbUserName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30*scale),
            lbUserName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -85*scale),
            lbUserName.heightAnchor.constraint(equalToConstant: 18*scale),
            
            lbKokoid.topAnchor.constraint(equalTo: lbUserName.bottomAnchor, constant: 8*scale),
            lbKokoid.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30*scale),
            lbKokoid.heightAnchor.constraint(equalToConstant: 18*scale),
            
            ivKoko.centerYAnchor.constraint(equalTo: lbKokoid.centerYAnchor),
            ivKoko.leadingAnchor.constraint(equalTo: lbKokoid.trailingAnchor),
            ivKoko.widthAnchor.constraint(equalToConstant: 18*scale),
            ivKoko.heightAnchor.constraint(equalToConstant: 18*scale),
            
            ivKokoBadge.centerYAnchor.constraint(equalTo: lbKokoid.centerYAnchor),
            ivKokoBadge.leadingAnchor.constraint(equalTo: ivKoko.trailingAnchor, constant: 21*scale),
            ivKokoBadge.widthAnchor.constraint(equalToConstant: 10*scale),
            ivKokoBadge.heightAnchor.constraint(equalToConstant: 10*scale),
            
            btnAvatar.topAnchor.constraint(equalTo: ivATM.bottomAnchor, constant: 27*scale),
            btnAvatar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30*scale),
            btnAvatar.widthAnchor.constraint(equalToConstant: 54*scale),
            btnAvatar.heightAnchor.constraint(equalToConstant: 54*scale),
        ])
    }
    
    func setupWithItem(item: UserModel) {
        self.item = item
        
        let name = item.name
        let kokoid = item.kokoid
        lbUserName?.text = name
        lbKokoid?.text = "\("KOKO ID：")\(kokoid)"
        ivKokoBadge?.alpha = 0
    }
}
