//
//  MainTabBar.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

class MainTabBar: UITabBar {
    let scale: CGFloat = UIFactory.getScale()
    var bg: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTabBar(tabBarConroller: UITabBarController) {
        setup(tabBarConroller: tabBarConroller)
//        roundTabBar(tabBarConroller: tabBarConroller)
        adjustTabBarPostion(tabBarConroller: tabBarConroller)
    }
    
    private func setup(tabBarConroller: UITabBarController) {
        items = tabBarConroller.tabBar.items
        barTintColor = .clear
        backgroundImage = UIImage()
        shadowImage = UIImage()
        
        setupBg(tabBarConroller: tabBarConroller)
    }
    
    private func setupBg(tabBarConroller: UITabBarController) {
        let bg = UIFactory.createImage(name: "imgTabbarBg")
        addSubview(bg)
        bg.backgroundColor = .clear
        bg.contentMode = .scaleToFill
        sendSubviewToBack(bg)
        self.bg = bg
        if let firstItem = items?[2],
           let firstItemView = firstItem.value(forKey: "view") as? UIView,
           let itemImageView = firstItemView.subviews.compactMap({ $0 as? UIImageView }).first {
            NSLayoutConstraint.activate([
                bg.leadingAnchor.constraint(equalTo: tabBarConroller.view.leadingAnchor),
                bg.trailingAnchor.constraint(equalTo: tabBarConroller.view.trailingAnchor),
                bg.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor),
                bg.topAnchor.constraint(equalTo: itemImageView.topAnchor)
            ])
        }
        
        let bg2 = UIFactory.createView(color: .white)
        addSubview(bg2)
        sendSubviewToBack(bg2)
        NSLayoutConstraint.activate([
            bg2.leadingAnchor.constraint(equalTo: tabBarConroller.view.leadingAnchor),
            bg2.trailingAnchor.constraint(equalTo: tabBarConroller.view.trailingAnchor),
            bg2.bottomAnchor.constraint(equalTo: tabBarConroller.view.bottomAnchor),
            bg2.topAnchor.constraint(equalTo: bg.bottomAnchor, constant: -1)
        ])
    }

    private func roundTabBar(tabBarConroller: UITabBarController) {
        let tabBar = self
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBarConroller.tabBar.bounds.minY + 5, width: tabBarConroller.tabBar.bounds.width - 60, height: tabBarConroller.tabBar.bounds.height + 10), cornerRadius: (tabBarConroller.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
  
        tabBar.layer.insertSublayer(layer, at: 0)
    }
    
    private func adjustTabBarPostion(tabBarConroller: UITabBarController) {
        let tabBar = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBar.leadingAnchor.constraint(equalTo: tabBarConroller.view.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: tabBarConroller.view.trailingAnchor),
            tabBar.bottomAnchor.constraint(equalTo: tabBarConroller.view.bottomAnchor),
            tabBar.heightAnchor.constraint(equalToConstant: 68*scale)
        ])
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 1
        
        // Set item width to reduce spacing
        if let items = tabBar.items, !items.isEmpty {
            tabBar.itemWidth = (tabBarConroller.view.frame.width - 30*scale) / CGFloat(items.count)
        }
    }
}
