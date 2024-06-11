//
//  FreindTabHeader.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation
import UIKit

protocol FriendTabHeaderDelegate: AnyObject {
    func friendTabTapped(index: Int)
}

class FriendTabHeader: UICollectionReusableView {
    static let headerID = "FriendTabHeader"

    weak var delegate: FriendTabHeaderDelegate?
    let scale: CGFloat = UIFactory.getScale()
    var curSelectIndex = 0
    
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
    
    var tabModels = [FriendTabModel]()
    var tabViews = [FriendTabView]()
    var bottomLine: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultData()
        setupUI()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupDefaultData() {
        tabModels.removeAll()
        tabModels.append(FriendTabModel(name: "好友".localized(), badgeCount: 0, isSelected: true))
        tabModels.append(FriendTabModel(name: "聊天".localized(), badgeCount: 0))
    }
    
    func setupUI() {
        backgroundColor = ColorEnum.white2.color
        
        let tabView1 = FriendTabView()
        tabView1.translatesAutoresizingMaskIntoConstraints = false
        
        tabViews.removeAll()
        var preV: FriendTabView?
        for i in  0..<tabModels.count {
            let model = tabModels[i]
            let v = createFriendTabView(model: model, tag: i)
            NSLayoutConstraint.activate([
                v.topAnchor.constraint(equalTo: topAnchor),
                v.bottomAnchor.constraint(equalTo: bottomAnchor),
                v.leadingAnchor.constraint(equalTo: preV != nil ? preV!.trailingAnchor : leadingAnchor, constant: preV != nil ? 0 : 30*scale),
                v.widthAnchor.constraint(equalToConstant: 62*scale),
            ])
            preV = v
            tabViews.append(v)
            
            v.btnAction = { [weak self] tag in
                guard let self = self else { return }
                self.updateSelectTab(index: tag)
            }
        }
        
        let bottomLine = UIFactory.createView(color: UIColor(red: 239, green: 239, blue: 239))
        addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    private func createFriendTabView(model: FriendTabModel, tag: Int) -> FriendTabView {
        let v = FriendTabView()
        v.tag = tag
        v.translatesAutoresizingMaskIntoConstraints = false
        v.setupWithFriendTabModel(model)
        addSubview(v)
        return v
    }
    
    func updateWithData(models: [FriendTabModel]) {
        tabModels = models
        updateSelectTab(index: curSelectIndex)
    }
    
    func updateSelectTab(index: Int) {
        let index = max(0, min(index, tabModels.count-1))
        curSelectIndex = index
        for i in 0..<tabModels.count {
            tabModels[i].updateIsSelected(to: i == index ? true : false)
            tabViews[i].setupWithFriendTabModel(tabModels[i])
        }
    }
}

class FriendTabView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var model: FriendTabModel?
    
    var lbTitle: UILabel!
    var vBadge: UIView!
    var lbBadge: UILabel!
    var vUnderLine: UIView!
    var btn: UIButton!
    var isSelected: Bool = false
    
    var btnAction: ((_ tag: Int) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let lbTitle = UIFactory.createLabel(size: 13*scale, text: "", color: ColorEnum.greyishBrown.color, font: .PingFangTCMedium)
        let vBadge = UIFactory.createView(color: ColorEnum.hotpink.color, corner: 9*scale)
        let lbBadge = UIFactory.createLabel(size: 12*scale, text: "", color: ColorEnum.white3.color, font: .PingFangTCMedium, textAlignment: .center)
        let vUnderLine = UIFactory.createView(color: ColorEnum.hotpink.color, corner: 2*scale)
        let btn = UIFactory.createImageButton(name: "")
        
        addSubview(lbTitle)
        addSubview(vBadge)
        addSubview(lbBadge)
        addSubview(vUnderLine)
        addSubview(btn)
        
        self.lbTitle = lbTitle
        self.vBadge = vBadge
        self.lbBadge = lbBadge
        self.vUnderLine = vUnderLine
        self.btn = btn
        
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            lbTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2*scale),
            lbTitle.heightAnchor.constraint(equalToConstant: 18*scale),
            
            vBadge.topAnchor.constraint(equalTo: topAnchor, constant: 3*scale),
            vBadge.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor, constant: 3*scale),
            vBadge.heightAnchor.constraint(equalToConstant: 18*scale),
            
            lbBadge.leadingAnchor.constraint(equalTo: vBadge.leadingAnchor, constant: 5*scale),
            lbBadge.trailingAnchor.constraint(equalTo: vBadge.trailingAnchor, constant: -5*scale),
            lbBadge.centerYAnchor.constraint(equalTo: vBadge.centerYAnchor),
            
            vUnderLine.leadingAnchor.constraint(equalTo: lbTitle.leadingAnchor),
            vUnderLine.trailingAnchor.constraint(equalTo: lbTitle.trailingAnchor),
            vUnderLine.heightAnchor.constraint(equalToConstant: 4*scale),
            vUnderLine.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1),
            
            btn.topAnchor.constraint(equalTo: topAnchor),
            btn.leadingAnchor.constraint(equalTo: leadingAnchor),
            btn.trailingAnchor.constraint(equalTo: vBadge.trailingAnchor, constant: 3*scale),
            btn.bottomAnchor.constraint(equalTo: bottomAnchor),
             
        ])
    }
    
    func setupWithFriendTabModel(_ model: FriendTabModel) {
        self.model = model
        
        lbTitle?.text = model.name
        let badgeCount = model.badgeCount
        if badgeCount > 0 {
            lbBadge?.text = badgeCount > 99 ? "99+" : "\(badgeCount)"
            lbBadge?.alpha = 1
            vBadge?.alpha = 1
        } else {
            lbBadge?.alpha = 0
            vBadge?.alpha = 0
        }
        
        vUnderLine?.alpha = model.isSelected ? 1.0 : 0
    }
    
    @objc func btnTapped() {
        btnAction?(self.tag)
    }
}
