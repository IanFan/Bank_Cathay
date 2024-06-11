//
//  FriendViewController.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation
import UIKit

class FriendViewController: UIViewController {
    let userViewModel = UserViewModel()
    let friendViewModel = FriendViewModel()
    
    let scale: CGFloat = UIFactory.getScale()
    var requestFriendType: RequestFriendType = .NoFriend
    var refreshControl: UIRefreshControl!
    var navigationView: HomeNavigationView!
//    var amountView: HomeAmountView!
//    var menuView: HomeMenuView!
//    var favoriteView: HomeFavoriteView!
//    var adView: HomeAdView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.userViewModel.delegate = self
        self.friendViewModel.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        self.userViewModel.loadData(isRefresh: false)
        self.friendViewModel.loadData(isRefresh: false, requestType: requestFriendType)
    }
    
    func setupUI() {
        /*
        view.backgroundColor = ColorEnum.localWhite2.color
        
        // UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90*scale, right: 0)
        view.addSubview(scrollView)
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorEnum.systemGray10.color
        scrollView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refreshControl = refreshControl
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // contentView
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // main stack
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = 0
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        // navigationView
        let navigationView = HomeNavigationView()
        view.addSubview(navigationView)
        self.navigationView = navigationView
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 48*scale),
        ])
        mainStackView.addArrangedSubview(navigationView)
        
        // amountView
        let amountView = HomeAmountView()
        self.amountView = amountView
        navigationView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(amountView)
        
        // menuView
        let menuView = HomeMenuView()
        view.addSubview(menuView)
        self.menuView = menuView
        menuView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            menuView.heightAnchor.constraint(equalToConstant: 192*scale),
        ])
        mainStackView.addArrangedSubview(menuView)
        
        // favoriteView
        let favoriteView = HomeFavoriteView(frame: .zero, favoriteViewModel: favoriteViewModel)
        view.addSubview(favoriteView)
        self.favoriteView = favoriteView
        favoriteView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            favoriteView.heightAnchor.constraint(equalToConstant: 136*scale),
        ])
        mainStackView.addArrangedSubview(favoriteView)
        
        // adView
        let adView = HomeAdView(frame: .zero, adBannerViewModel: adBannerViewModel)
        view.addSubview(adView)
        self.adView = adView
        adView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            adView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            adView.heightAnchor.constraint(equalToConstant: 116*scale),
        ])
        mainStackView.addArrangedSubview(adView)
        
        // action
        navigationView.btnAvatarAction = { [weak self] in
            guard let self = self else { return }
        }
        navigationView.btnBellAction = { [weak self] in
            guard let self = self else { return }
            let vc = NotificationViewController(messageViewModel: self.messageViewModel)
            self.navigationController?.pushViewController(vc, animated: true)
        }
         */
    }
    
}

extension FriendViewController {
    @objc func handleRefresh() {
        self.userViewModel.loadData(isRefresh: true)
        self.friendViewModel.loadData(isRefresh: true, requestType: requestFriendType)
        
        self.refreshControl?.endRefreshing()
    }
}

extension FriendViewController: UserViewModelProtocol {
    func updateUserUI() {
        
    }
}

extension FriendViewController: FriendViewModelProtocol {
    func updateFriendUI() {
    }
}
