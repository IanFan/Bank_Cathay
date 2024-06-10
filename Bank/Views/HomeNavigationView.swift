//
//  HomeNavigationView.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class HomeNavigationView: UIView {
    var btnAvatar: UIButton!
    var btnBell: UIButton!
    
    let scale: CGFloat = UIFactory.getScale()
    
    var btnAvatarAction: (() -> Void)?
    var btnBellAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let btnAvatar = UIFactory.createImageButton(name: "avatar", corner: 20*scale)
        let btnBell = UIFactory.createImageButton(name: "iconBell01Nomal")
        
        btnAvatar.contentMode = .scaleAspectFit
        btnBell.contentMode = .scaleAspectFit
        
        btnAvatar.addTarget(self, action: #selector(btnAvatarTapped), for: .touchUpInside)
        btnBell.addTarget(self, action: #selector(btnBellTapped), for: .touchUpInside)
        
        self.btnAvatar = btnAvatar
        self.btnBell = btnBell
        
        addSubview(btnAvatar)
        addSubview(btnBell)
        
        NSLayoutConstraint.activate([
            btnAvatar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24*scale),
            btnAvatar.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnAvatar.widthAnchor.constraint(equalToConstant: 40*scale),
            btnAvatar.heightAnchor.constraint(equalToConstant: 40*scale),
            
            btnBell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24*scale),
            btnBell.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnBell.widthAnchor.constraint(equalToConstant: 24*scale),
            btnBell.heightAnchor.constraint(equalToConstant: 24*scale),
        ])
    }
    
    func setupContent(isShowBellBadge: Bool) {
        let imgBell = isShowBellBadge ? UIImage(named: "iconBell02Active") : UIImage(named: "iconBell01Nomal")
        btnBell?.setBackgroundImage(imgBell, for: .normal)
    }
    
    @objc private func btnAvatarTapped() {
        btnAvatarAction?()
    }
    
    @objc private func btnBellTapped() {
        btnBellAction?()
    }
}
