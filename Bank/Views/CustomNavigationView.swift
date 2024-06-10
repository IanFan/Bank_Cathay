//
//  CustomNavigationView.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class CustomNavigationView: UIView {
    private lazy var ivBack: UIImageView = {
        let iv = UIFactory.createImage(name: "iconArrowWTailBack")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var btnBack: UIButton = {
        let btn = UIFactory.createImageButton(name: "")
        btn.addTarget(self, action: #selector(btnBackTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var lbTitle: UILabel = {
        let lb = UIFactory.createLabel(size: 18*scale, text: "Notificaiton".localized(), color: ColorEnum.systemGray10.color, font: .SFProTextMedium)
        lb.textAlignment = .center
        return lb
    }()
    
    var title: String? {
        didSet {
            lbTitle.text = title
        }
    }
    
    var btnBackAction: (() -> Void)?
    let scale: CGFloat = UIFactory.getScale()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        addSubview(ivBack)
        addSubview(btnBack)
        addSubview(lbTitle)
        
        NSLayoutConstraint.activate([
            ivBack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15*scale),
            ivBack.centerYAnchor.constraint(equalTo: centerYAnchor),
            ivBack.widthAnchor.constraint(equalToConstant: 24*scale),
            ivBack.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnBack.leadingAnchor.constraint(equalTo: leadingAnchor),
            btnBack.topAnchor.constraint(equalTo: topAnchor),
            btnBack.bottomAnchor.constraint(equalTo: bottomAnchor),
            btnBack.widthAnchor.constraint(equalToConstant: 50*scale),
            
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50*scale),
            lbTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50*scale),
            lbTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            lbTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    @objc private func btnBackTapped() {
        btnBackAction?()
        print("btnBackTapped")
    }
}
