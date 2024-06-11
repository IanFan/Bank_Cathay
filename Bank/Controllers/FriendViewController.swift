//
//  FriendViewController.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/10.
//

import Foundation
import UIKit

enum FriendSection: Int, CaseIterable {
    case User = 0
    case InviteFriend = 1
    case Freind = 2
}

class FriendViewController: UIViewController {
    let userViewModel = UserViewModel()
    let friendViewModel = FriendViewModel()
    
    let scale: CGFloat = UIFactory.getScale()
    var requestFriendType: RequestFriendType = .NoFriend
    var cv: UICollectionView!
    var refreshControl: UIRefreshControl!
    var userHeader: FriendUserHeader?
    var friendTabHeader: FriendTabHeader?
    var friendEmptyFooter: FriendEmptyFooter?
    
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
        
        showRequestPopView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.requestAPIs(isRefresh: false)
        }
    }
    
    func setupUI() {
        view.backgroundColor = ColorEnum.white2.color
        
        // collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        // register cells
        cv.register(FriendInviteCell.self, forCellWithReuseIdentifier: FriendInviteCell.cellID)
        //register headers
        cv.register(FriendUserHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendUserHeader.headerID)
        cv.register(FriendTabHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendTabHeader.headerID)
        //register footers
        cv.register(FriendEmptyFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FriendEmptyFooter.headerID)
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
    
    func requestAPIs(isRefresh: Bool) {
        self.userViewModel.loadData(isRefresh: isRefresh)
        self.friendViewModel.loadData(isRefresh: isRefresh, requestType: self.requestFriendType)
    }
}

extension FriendViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return FriendSection.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case FriendSection.User.rawValue:
            return 0
        case FriendSection.InviteFriend.rawValue:
            return 0
        case FriendSection.Freind.rawValue:
            return 0
        default:
            return 0
        }
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
        // header
        if kind == UICollectionView.elementKindSectionHeader {
            let section = indexPath.section
            switch section {
            case FriendSection.User.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendUserHeader.headerID, for: indexPath) as! FriendUserHeader
                header.delegate = self
                self.userHeader = header
                return header
            case FriendSection.InviteFriend.rawValue:
                return UICollectionReusableView()
            case FriendSection.Freind.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendTabHeader.headerID, for: indexPath) as! FriendTabHeader
                header.delegate = self
                self.friendTabHeader = header
                return header
            default:
                return UICollectionReusableView()
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            let section = indexPath.section
            switch section {
            case FriendSection.User.rawValue:
                return UICollectionReusableView()
            case FriendSection.InviteFriend.rawValue:
                return UICollectionReusableView()
            case FriendSection.Freind.rawValue:
                switch requestFriendType {
                case .NoFriend:
                    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendEmptyFooter.headerID, for: indexPath) as! FriendEmptyFooter
                    footer.delegate = self
                    self.friendEmptyFooter = footer
                    return footer
                default:
                    return UICollectionReusableView()
                }
            default:
                return UICollectionReusableView()
            }
        } else {
            return UICollectionReusableView()
        }
    }
}

extension FriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let section = indexPath.section
        let width = collectionView.frame.width
        switch section {
        case FriendSection.User.rawValue:
            return CGSize(width: width, height: 0)
        case FriendSection.InviteFriend.rawValue:
            return CGSize(width: width, height: 0)
        case FriendSection.Freind.rawValue:
            return CGSize(width: width, height: 0)
        default:
            return CGSize(width: width, height: 100*scale)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        switch section {
        case FriendSection.User.rawValue:
            return CGSize(width: width, height: 142*scale)
        case FriendSection.InviteFriend.rawValue:
            return CGSize(width: width, height: 0)
        case FriendSection.Freind.rawValue:
            return CGSize(width: width, height: 38*scale)
        default:
            return CGSize(width: width, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        switch section {
        case FriendSection.User.rawValue:
            return CGSize(width: width, height: 0)
        case FriendSection.InviteFriend.rawValue:
            return CGSize(width: width, height: 0)
        case FriendSection.Freind.rawValue:
            return CGSize(width: width, height: 460*scale)
        default:
            return CGSize(width: width, height: 0)
        }
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
        guard let friendTabHeader = friendTabHeader else {
            return
        }
        let friendBadgeCount = friendViewModel.getCompleteFriendCount()
        var tabModels = [FriendTabModel]()
        let tabName1 = "好友".localized()
        let tabName2 = "聊天".localized()
        switch requestFriendType {
        case .NoFriend:
            tabModels.append(FriendTabModel(name: tabName1, badgeCount: 0))
            tabModels.append(FriendTabModel(name: tabName2, badgeCount: 0))
        case .FriendWithMixedSource:
            tabModels.append(FriendTabModel(name: tabName1, badgeCount: 0))
            tabModels.append(FriendTabModel(name: tabName2, badgeCount: 100))
        case .FriendAndInvite:
            tabModels.append(FriendTabModel(name: tabName1, badgeCount: friendBadgeCount))
            tabModels.append(FriendTabModel(name: tabName2, badgeCount: 100))
        }
        friendTabHeader.updateWithData(models: tabModels)
    }
}

extension FriendViewController: FriendUserHeaderDelegate {
    
}

extension FriendViewController: FriendTabHeaderDelegate {
    func friendTabTapped(index: Int) {
        print("friendTabTapped \(index)")
    }
}

extension FriendViewController: FriendEmptybFooterDelegate {
    
}

extension FriendViewController {
    func showRequestPopView() {
        let alertController = UIAlertController(title: "Request Options", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Without Friend", style: .default) { action in
            print("Button 1 tapped")
            self.requestFriendType = .NoFriend
            self.requestAPIs(isRefresh: false)
        }
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: "Friend List Only", style: .default) { action in
            self.requestFriendType = .FriendWithMixedSource
            self.requestAPIs(isRefresh: false)
        }
        alertController.addAction(action2)
        
        let action3 = UIAlertAction(title: "Friend List & Invite List", style: .default) { action in
            self.requestFriendType = .FriendAndInvite
            self.requestAPIs(isRefresh: false)
        }
        alertController.addAction(action3)
        
        present(alertController, animated: true, completion: nil)
    }
}
