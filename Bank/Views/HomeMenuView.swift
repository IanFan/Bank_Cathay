//
//  HomeMenuView.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class HomeMenuView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var menus = [HomeMenuModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDefaultData()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDefaultData()
        setupViews()
    }
    
    private func setupDefaultData() {
        menus.removeAll()
        
        menus.append(HomeMenuModel(title: "Transfer", imageName: "button00ElementMenuTransfer"))
        menus.append(HomeMenuModel(title: "Payment", imageName: "button00ElementMenuPayment"))
        menus.append(HomeMenuModel(title: "Utility", imageName: "button00ElementMenuUtility"))
        menus.append(HomeMenuModel(title: "QR pay scan", imageName: "button01Scan"))
        menus.append(HomeMenuModel(title: "My QR code", imageName: "button00ElementMenuTransfer"))
        menus.append(HomeMenuModel(title: "Top up", imageName: "button00ElementMenuTopUp"))
    }
    
    private func setupViews() {
        let width = UIFactory.getWindowSize().width
        let rowCount: Int = 3
        let itemWidth = CGFloat(width/CGFloat(rowCount))
        let itemHeight = 96*scale
        for i in 0..<menus.count {
            let v = MenuView()
            addSubview(v)
            v.translatesAutoresizingMaskIntoConstraints  = false
            
            NSLayoutConstraint.activate([
                v.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(i/rowCount)*itemHeight),
                v.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(i%rowCount)*itemWidth),
                v.widthAnchor.constraint(equalToConstant: itemWidth),
                v.heightAnchor.constraint(equalToConstant: itemHeight),
            ])
            
            v.setupContent(model: menus[i])
        }
    }
}

class MenuView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var item: HomeMenuModel?
    var btnIcon: UIButton!
    var lbTitle: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let btnIcon = UIFactory.createImageButton(name: "", corner: 28*scale)
        let lbTitle = UIFactory.createLabel(size: 14*scale, text: "", color: ColorEnum.systemGray7.color, font: .SFProTextRegular)
        
        self.btnIcon = btnIcon
        self.lbTitle = lbTitle
        
        addSubview(btnIcon)
        addSubview(lbTitle)
        
        lbTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([
            btnIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8*scale),
            btnIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            btnIcon.widthAnchor.constraint(equalToConstant: 56*scale),
            btnIcon.heightAnchor.constraint(equalToConstant: 56*scale),
            
            lbTitle.topAnchor.constraint(equalTo: btnIcon.bottomAnchor, constant: 1*scale),
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8*scale),
            lbTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8*scale),
        ])
    }
    
    func setupContent(model: HomeMenuModel) {
        self.item = model
        
        btnIcon?.setBackgroundImage(UIImage(named: model.imageName), for: .normal)
        lbTitle?.text = model.title.localized()
    }
}
