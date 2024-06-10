//
//  MainTabBarController.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

enum MainTabEnum: Int {
    case Home = 0
    case Account = 1
    case Location = 2
    case Service = 3
    
    var stringValue: String {
        switch self {
        case .Home:
            return "Home"
        case .Account:
            return "Account"
        case .Location:
            return "Location"
        case .Service:
            return "Service"
        }
    }
    
    var imageName: String {
        switch self {
        case .Home:
            return "icTabbarHomeActive"
        case .Account:
            return "icTabbarAccount"
        case .Location:
            return "icTabbarLocationActive"
        case .Service:
            return "icTabbarLocationActive"
        }
    }
    
    var selectedImageName: String {
        switch self {
        case .Home:
            return "icTabbarHomeActive"
        case .Account:
            return "icTabbarAccount"
        case .Location:
            return "icTabbarLocationActive"
        case .Service:
            return "icTabbarLocationActive"
        }
    }
}

class MainTabBarController: UITabBarController {
    var customTabBar: MainTabBar!
    
    let scale: CGFloat = UIFactory.getScale()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.isHidden = true
        
        let firstVC = createMainViewController(tabEnum: .Home)
        let secondVC = createMainViewController(tabEnum: .Account)
        let thirdVC = createMainViewController(tabEnum: .Location)
        let forthVC = createMainViewController(tabEnum: .Service)
        self.viewControllers = [firstVC, secondVC, thirdVC, forthVC]
        
        let customTabBar = MainTabBar()
        self.view.addSubview(customTabBar)
        customTabBar.setupTabBar(tabBarConroller: self)
        self.delegate = self
        
        updateTabBarAppearance()
    }
    
    private func createMainViewController(tabEnum: MainTabEnum) -> UIViewController {
        if tabEnum == .Home {
            let vc = HomeViewController()
            vc.tabBarItem = createTabBarItem(tabEnum: tabEnum)
            return vc
        } else {
            let vc = UIViewController()
            vc.view.backgroundColor = ColorEnum.localWhite2.color
            vc.tabBarItem = createTabBarItem(tabEnum: tabEnum)
            
            let lb = UIFactory.createLabel(size: 18*scale, text: "View Controller: \(tabEnum)", color: ColorEnum.systemGray5.color, font: .SFProTextHeavy)
            vc.view.addSubview(lb)
            NSLayoutConstraint.activate([
                lb.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                lb.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor),
            ])
            return vc
        }
    }
    
    private func createTabBarItem(tabEnum: MainTabEnum) -> UITabBarItem {
        let titleStr = tabEnum.stringValue
        let tabTitleColorHexSelect: String = "#FF8861"
        let tabTitleColorHex: String = "#555555"
        let imageName = tabEnum.imageName
        let selectedImageName = tabEnum.selectedImageName
        
        let title = titleStr
        let tab = UITabBarItem.init(title: title,
                                    image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal))
        tab.setTitleTextAttributes([.foregroundColor : UIColor(hexString: tabTitleColorHex)], for: .normal)
        tab.setTitleTextAttributes([.foregroundColor : UIColor(hexString: tabTitleColorHexSelect)], for: .selected)
        tab.tag = tabEnum.rawValue
        
        // Adjust vertical position of icon
        tab.imageInsets = UIEdgeInsets(top: 7*scale, left: 0, bottom: -7*scale, right: 0)
        // Adjust vertical position of text
        tab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6*scale)
        
        return tab
    }
    
    private func updateTabBarAppearance() {
        let tabBarItemAppearance = UITabBarItemAppearance()
        
        tabBarItemAppearance.selected.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorEnum.localOrange1.color,
            .font : UIFont(name: FontEnum.SFProTextSemibold.rawValue, size: 12*scale) ?? UIFont.boldSystemFont(ofSize: 12*scale)]
        tabBarItemAppearance.normal.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: ColorEnum.systemGray7.color,
            .font : UIFont(name: FontEnum.SFProTextRegular.rawValue, size: 12*scale) ?? UIFont.systemFont(ofSize: 12*scale)]
        
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance
        tabBarAppearance.backgroundColor = .clear
        
        self.tabBar.standardAppearance = tabBarAppearance
        self.tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let tabItems = tabBarController.tabBar.items else { return }
        
        for item in tabItems {
            if item == tabBarController.tabBar.selectedItem {
                item.setTitleTextAttributes([.foregroundColor : ColorEnum.localOrange1.color,
                                             .font : UIFont(name: FontEnum.SFProTextSemibold.rawValue, size: 12*scale) ?? UIFont.boldSystemFont(ofSize: 12*scale)], for: .normal)
            } else {
                item.setTitleTextAttributes([.foregroundColor : ColorEnum.systemGray7.color,
                                             .font : UIFont(name: FontEnum.SFProTextRegular.rawValue, size: 12*scale) ?? UIFont.systemFont(ofSize: 12*scale)], for: .normal)
            }
        }
    }
}
