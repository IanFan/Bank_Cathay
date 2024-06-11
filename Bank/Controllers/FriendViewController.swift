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
    var cv: UICollectionView!
    var refreshControl: UIRefreshControl!
    var userHeader: FriendUserHeader?
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.userViewModel.loadData(isRefresh: false)
            self.friendViewModel.loadData(isRefresh: false, requestType: self.requestFriendType)
        }
    }
    
    func setupUI() {
        view.backgroundColor = ColorEnum.white3.color
        
        // collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.register(FriendInviteCell.self, forCellWithReuseIdentifier: FriendInviteCell.cellID)
        cv.register(FriendUserHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendUserHeader.headerID)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        view.addSubview(cv)
        self.cv = cv
        
        // pull refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorEnum.greyishBrown.color
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        cv.refreshControl = refreshControl
        self.refreshControl = refreshControl
        
        // layout
        NSLayoutConstraint.activate([
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cv.topAnchor.constraint(equalTo: view.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        /*
        
        
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

extension FriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        // header User
        // header Friend Tab
        // footer Friend Empty
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let obj = messages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendInviteCell.cellID, for: indexPath) as! FriendInviteCell
//        cell.setupWithItem(item: obj)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectSectionIndex = indexPath.section
        let selectIndex = indexPath.item
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? NotificationCell, let obj: MessageModel = cell.message else {
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
        if section == 0 {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendUserHeader.headerID, for: indexPath) as! FriendUserHeader
            header.backgroundColor = .randomColor
            header.delegate = self
            self.userHeader = header
            return header
        }
        return UICollectionReusableView()
    }
}

extension FriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let width = collectionView.frame.width
        if section == 0 {
            return CGSize(width: width, height: 20)
        }
        
        let size = CGSize(width: width, height: 128 * scale)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        if section == 0 {
            return CGSize(width: width, height: 142*scale)
        }
        
        let size = CGSize(width: width, height: 128 * scale)
        return size
    }
}

extension FriendViewController {
    @objc func refreshCollectionView(_ sender: UIRefreshControl) {
        self.userViewModel.loadData(isRefresh: true)
        self.friendViewModel.loadData(isRefresh: true, requestType: requestFriendType)
        
        sender.endRefreshing()
    }
}

extension FriendViewController: UserViewModelProtocol {
    func updateUserUI() {
        guard let item = userViewModel.getUserItem() else {
            return
        }
        userHeader?.setupWithItem(item: item)
    }
}

extension FriendViewController: FriendViewModelProtocol {
    func updateFriendUI() {
    }
}

extension FriendViewController: FriendUserHeaderDelegate {
    
}
