//
//  HomeAmountView.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class HomeAmountView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var modelsDic = [String: HomeMoenyModel]()
    var moneyViewsDic = [String : HomeMoneyView]()
    var lbTitle: UILabel!
    var btnEye: UIButton!
    var ivEye: UIImageView!
    
//    var btnEyeAction: ((_ isEyeHided: Bool) -> Void)?
    var isEyeHided = false
    
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
        modelsDic.removeAll()
        moneyViewsDic.removeAll()
        
        let currs = ["USD", "KHR"]
        for curr in currs {
            modelsDic[curr] = HomeMoenyModel(curr: curr, balance: nil)
        }
    }
    
    private func setupViews() {
        let topContainer = UIFactory.createView(color: .clear)
        let lbTitle = UIFactory.createLabel(size: 18*scale, text: "My Account Balance".localized(), color: ColorEnum.systemGray5.color, font: .SFProTextBold)
        let btnEye = UIFactory.createImageButton(name: "")
        let ivEye = UIFactory.createImage(name: "iconEye01On")
        
        self.lbTitle = lbTitle
        self.btnEye = btnEye
        self.ivEye = ivEye
        
        addSubview(topContainer)
        addSubview(lbTitle)
        addSubview(btnEye)
        addSubview(ivEye)
        
        ivEye.contentMode = .scaleAspectFit
        btnEye.addTarget(self, action: #selector(btnEyeTapped), for: .touchUpInside)
        
        let margin = 24*scale
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.heightAnchor.constraint(equalToConstant: 48*scale),
            
            lbTitle.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            lbTitle.heightAnchor.constraint(equalToConstant: 24*scale),
            
            btnEye.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor),
            btnEye.topAnchor.constraint(equalTo: topAnchor),
            btnEye.heightAnchor.constraint(equalToConstant: 48*scale),
            btnEye.widthAnchor.constraint(equalToConstant: 48*scale),
            
            ivEye.leadingAnchor.constraint(equalTo: lbTitle.trailingAnchor, constant: 8*scale),
            ivEye.centerYAnchor.constraint(equalTo: lbTitle.centerYAnchor),
            ivEye.heightAnchor.constraint(equalToConstant: 24*scale),
            ivEye.widthAnchor.constraint(equalToConstant: 24*scale),
        ])
        
        let smallStackView = UIStackView()
        smallStackView.axis = .vertical
        smallStackView.spacing = 0
        smallStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(smallStackView)
        
        NSLayoutConstraint.activate([
            smallStackView.topAnchor.constraint(equalTo: topAnchor, constant: 48*scale),
            smallStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            smallStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            smallStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
//        for (curr, model) in modelsDic {
        if let model = modelsDic["USD"] {
            let smallView = HomeMoneyView()
            smallView.translatesAutoresizingMaskIntoConstraints = false
            smallView.heightAnchor.constraint(equalToConstant: 64*scale).isActive = true
            smallView.setupContentHomeMoenyModel(model, isEyeHided: isEyeHided)
            
            smallStackView.addArrangedSubview(smallView)
            moneyViewsDic[model.curr] = smallView
        }
        if let model = modelsDic["KHR"] {
            let smallView = HomeMoneyView()
            smallView.translatesAutoresizingMaskIntoConstraints = false
            smallView.heightAnchor.constraint(equalToConstant: 64*scale).isActive = true
            smallView.setupContentHomeMoenyModel(model, isEyeHided: isEyeHided)
            
            smallStackView.addArrangedSubview(smallView)
            moneyViewsDic[model.curr] = smallView
        }
    }
    
    func updateContent(curr: String , sum: Double) {
        if let v = moneyViewsDic[curr] {
            let model = HomeMoenyModel(curr: curr, balance: sum)
            modelsDic[curr] = model
            v.setupContentHomeMoenyModel(model, isEyeHided: isEyeHided)
        }
    }
    
    @objc private func btnEyeTapped() {
        isEyeHided = !isEyeHided
//        btnEyeAction?(isEyeHided)
        
        ivEye?.image = isEyeHided ? UIImage(named: "iconEye02Off") : UIImage(named: "iconEye01On")
        
        for (curr, model) in modelsDic {
            if let v = moneyViewsDic[curr] {
                v.setupContentHomeMoenyModel(model, isEyeHided: isEyeHided)
            }
        }
    }
}

class HomeMoneyView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var item: HomeMoenyModel?
    var lbCurr: UILabel!
    var vLoading: UIView!
    var lbBalance: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let lbCurr = UIFactory.createLabel(size: 16*scale, text: "", color: ColorEnum.systemGray7.color, font: .SFProTextRegular)
        let vLoading = UIFactory.createView(color: .clear)
        let lbBalance = UIFactory.createLabel(size: 24*scale, text: "", color: ColorEnum.systemGray8.color, font: .SFProTextMedium)
        
        self.lbCurr = lbCurr
        self.vLoading = vLoading
        self.lbBalance = lbBalance
        
        addSubview(lbCurr)
        addSubview(vLoading)
        addSubview(lbBalance)
        
        UIFactory.addGradient(view: vLoading, colorStart: ColorEnum.localWhite3.color, colorEnd: ColorEnum.localWhite1.color, width: 327*scale, height: 24*scale, corner: 0, isLeftToRight: true)
        
        let margin = 24*scale
        NSLayoutConstraint.activate([
            lbCurr.topAnchor.constraint(equalTo: topAnchor, constant: 4*scale),
            lbCurr.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            lbCurr.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            lbCurr.heightAnchor.constraint(equalToConstant: 24*scale),
            
            vLoading.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            vLoading.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            vLoading.topAnchor.constraint(equalTo: lbCurr.bottomAnchor),
            vLoading.heightAnchor.constraint(equalToConstant: 24*scale),
            
            lbBalance.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            lbBalance.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin),
            lbBalance.topAnchor.constraint(equalTo: lbCurr.bottomAnchor),
            lbBalance.heightAnchor.constraint(equalToConstant: 32*scale),
        ])
    }
    
    func setupContentHomeMoenyModel(_ model: HomeMoenyModel, isEyeHided: Bool) {
        self.item = model
        
        lbCurr?.text = model.curr.uppercased()
        
        if let formattedBalance = model.formattedBalance {
            vLoading?.alpha = 0
            if isEyeHided {
                lbBalance?.text = "********"
            } else {
                lbBalance?.text = formattedBalance
            }
        } else {
            lbBalance?.text = ""
            vLoading?.alpha = 1
        }
        
    }
}
