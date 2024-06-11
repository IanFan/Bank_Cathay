//
//  MainTabBarController.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/8.
//

import Foundation
import UIKit

struct TabInfo {
    let title: String
    let imageName: String
    let selectedImageName: String
}
enum MainTabEnum: Int {
    case Product = 0
    case Friend = 1
    case Home = 2
    case Manage = 3
    case Setting = 4
    
    var tabInfo: TabInfo {
        switch self {
        case .Product: return TabInfo(title: "錢錢", imageName: "icTabbarProductsOff_3", selectedImageName: "icTabbarProductsOff_3")
        case .Friend: return TabInfo(title: "朋友", imageName: "icTabbarFriendsOn_3", selectedImageName: "icTabbarFriendsOn_3")
        case .Home: return TabInfo(title: "", imageName: "icTabbarHomeOff", selectedImageName: "icTabbarHomeOff")
        case .Manage: return TabInfo(title: "記帳", imageName: "icTabbarManageOff_3", selectedImageName: "icTabbarManageOff_3")
        case .Setting: return TabInfo(title: "設定", imageName: "icTabbarSettingOff_3", selectedImageName: "icTabbarSettingOff_3")
        }
    }
}

class MainTabBarController: UITabBarController {
    let scale: CGFloat = UIFactory.getScale()
    var customTabBar: MainTabBar!
    
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
        
        let vc1 = createMainViewController(tabEnum: .Product)
        let vc2 = createMainViewController(tabEnum: .Friend)
        let vc3 = createMainViewController(tabEnum: .Home)
        let vc4 = createMainViewController(tabEnum: .Manage)
        let vc5 = createMainViewController(tabEnum: .Setting)
        self.viewControllers = [vc1, vc2, vc3, vc4, vc5]
        
        let customTabBar = MainTabBar()
        self.view.addSubview(customTabBar)
        self.customTabBar = customTabBar
        customTabBar.setupTabBar(tabBarConroller: self)
        self.delegate = self
        updateTabBarAppearance()
        
        self.selectTabIndex(MainTabEnum.Friend.rawValue)
    }
    
    private func createMainViewController(tabEnum: MainTabEnum) -> UIViewController {
        if tabEnum == .Friend {
            let vc = FriendViewController()
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
        let tabInfo = tabEnum.tabInfo
        let titleStr = tabInfo.title
        let imageName = tabInfo.imageName
        let selectedImageName = tabInfo.selectedImageName
        let tabTitleColorHexSelect: UIColor = .clear
        let tabTitleColorHex: UIColor = .clear
        
        let title = ""
        let tab = UITabBarItem.init(title: title,
                                    image: UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: UIImage(named: selectedImageName)?.withRenderingMode(.alwaysOriginal))
        tab.setTitleTextAttributes([.foregroundColor : tabTitleColorHex], for: .normal)
        tab.setTitleTextAttributes([.foregroundColor : tabTitleColorHexSelect], for: .selected)
        tab.tag = tabEnum.rawValue
        
        // Adjust vertical position of icon
        // Adjust vertical position of text
        if tabEnum != .Home {
            if UIFactory.isPad() {
                tab.imageInsets = UIEdgeInsets(top: 2*scale, left: 0, bottom: -2*scale, right: 0)
//                tab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6*scale)
            } else {
                tab.imageInsets = UIEdgeInsets(top: 6*scale, left: 0, bottom: -6*scale, right: 0)
//                tab.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 6*scale)
            }
        }
        
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
    
    func selectTabIndex(_ index: Int) {
        guard let items = customTabBar?.items, !items.isEmpty else {
            return
        }
        
        let index = max(min(index, items.count-1), 0)
        customTabBar?.selectedItem = items[index]
        self.selectedIndex = index
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        /*
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
        */
    }
}
