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
    case InviteFriendList = 1
    case FreindTab = 2
    case FreindSearch = 3
    case FriendList = 4
}

class FriendViewController: UIViewController {
    let userViewModel = UserViewModel()
    let friendViewModel = FriendViewModel()
    
    let scale: CGFloat = UIFactory.getScale()
    var requestFriendType: RequestFriendType = .FriendWithMixedSource
    var cv: UICollectionView!
    var refreshControl: UIRefreshControl!
    var userHeader: FriendUserHeader?
    var friendTabHeader: FriendTabHeader?
    var friendListSearchHeader: FriendListSearchHeader?
    var friendEmptyFooter: FriendEmptyFooter?
    let cellID = "cellID"
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.requestAPIs(isRefresh: false)
//            self.showRequestPopView()
        }
    }
    
    func setupUI() {
        view.backgroundColor = ColorFactory.white3
        
        // collectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
//        flowLayout.sectionHeadersPinToVisibleBounds = true
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        // register cells
        cv.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        cv.register(FriendInviteListCell.self, forCellWithReuseIdentifier: FriendInviteListCell.cellID)
        cv.register(FriendListCell.self, forCellWithReuseIdentifier: FriendListCell.cellID)
        //register headers
        cv.register(FriendUserHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendUserHeader.headerID)
        cv.register(FriendTabHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendTabHeader.headerID)
        cv.register(FriendListSearchHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: FriendListSearchHeader.headerID)
        //register footers
        cv.register(FriendEmptyFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: FriendEmptyFooter.headerID)
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        view.addSubview(cv)
        self.cv = cv
        
        // tap gesture
        cv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cvTapped(sender:)))
        cv.addGestureRecognizer(tapGesture)
        
        // pull refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorFactory.greyishBrown
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        cv.refreshControl = refreshControl
        self.refreshControl = refreshControl
        
        // layout
        NSLayoutConstraint.activate([
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func requestAPIs(isRefresh: Bool) {
        self.userViewModel.loadData(isRefresh: isRefresh)
        self.friendViewModel.loadData(isRefresh: isRefresh, requestType: self.requestFriendType)
    }
    
    @objc func cvTapped(sender: UITapGestureRecognizer) {
        print("cvTapped")
        let _ = friendListSearchHeader?.resignFirstResponder()
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
        case FriendSection.InviteFriendList.rawValue:
            return 0
        case FriendSection.FreindTab.rawValue:
            return 0
        case FriendSection.FreindSearch.rawValue:
            return 0
        case FriendSection.FriendList.rawValue:
            return friendViewModel.getFriendListCount(checkSearch: true)
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        let row = indexPath.row
        switch section {
        case FriendSection.User.rawValue:
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        case FriendSection.InviteFriendList.rawValue:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendInviteListCell.cellID, for: indexPath) as! FriendInviteListCell
            return cell
        case FriendSection.FreindTab.rawValue:
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        case FriendSection.FreindSearch.rawValue:
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        case FriendSection.FriendList.rawValue:
            let obj = friendViewModel.getFriendList(checkSearch: true)[row]
            let item = FriendListModel(name: obj.name, status: obj.status, isTop: obj.isTop, fid: obj.fid, updateDate: obj.updateDate, updateDateTime: obj.updateDateTime ?? 0, isTopInt: obj.isTopInt)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FriendListCell.cellID, for: indexPath) as! FriendListCell
            cell.setupWithItem(item: item)
            return cell
        default:
            return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectSectionIndex = indexPath.section
        let selectIndex = indexPath.item
        print("select:\(indexPath.section) \(indexPath.row)")
        
//        guard let cell = collectionView.cellForItem(at: indexPath) as? NotificationCell, let obj: MessageModel = cell.message else {
//            return
//        }
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
            case FriendSection.InviteFriendList.rawValue:
                return UICollectionReusableView()
            case FriendSection.FreindTab.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendTabHeader.headerID, for: indexPath) as! FriendTabHeader
                header.delegate = self
                self.friendTabHeader = header
                return header
            case FriendSection.FreindSearch.rawValue:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendListSearchHeader.headerID, for: indexPath) as! FriendListSearchHeader
                header.delegate = self
                self.friendListSearchHeader = header
                return header
            case FriendSection.FriendList.rawValue:
                return UICollectionReusableView()
            default:
                return UICollectionReusableView()
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            let section = indexPath.section
            switch section {
            case FriendSection.User.rawValue:
                return UICollectionReusableView()
            case FriendSection.InviteFriendList.rawValue:
                return UICollectionReusableView()
            case FriendSection.FreindTab.rawValue:
                if friendViewModel.getFriendListCount(checkSearch: false) == 0 {
                    let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: FriendEmptyFooter.headerID, for: indexPath) as! FriendEmptyFooter
                    footer.delegate = self
                    self.friendEmptyFooter = footer
                    return footer
                } else {
                    return UICollectionReusableView()
                }
            case FriendSection.FreindSearch.rawValue:
                return UICollectionReusableView()
            case FriendSection.FriendList.rawValue:
                return UICollectionReusableView()
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
            return CGSize.zero
        case FriendSection.InviteFriendList.rawValue:
            return CGSize.zero
        case FriendSection.FreindTab.rawValue:
            return CGSize.zero
        case FriendSection.FreindSearch.rawValue:
            return CGSize.zero
        case FriendSection.FriendList.rawValue:
            return CGSize(width: width, height: 60*scale)
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
        case FriendSection.InviteFriendList.rawValue:
            return CGSize.zero
        case FriendSection.FreindTab.rawValue:
            return CGSize(width: width, height: 38*scale)
        case FriendSection.FreindSearch.rawValue:
            return friendViewModel.getFriendListCount(checkSearch: false) > 0 ?
            CGSize(width: width, height: 61*scale) : CGSize(width: width, height: 0)
        case FriendSection.FriendList.rawValue:
            return CGSize.zero
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = collectionView.frame.width
        switch section {
        case FriendSection.User.rawValue:
            return CGSize.zero
        case FriendSection.InviteFriendList.rawValue:
            return CGSize.zero
        case FriendSection.FreindTab.rawValue:
            return friendViewModel.getFriendListCount(checkSearch: false) > 0 ?
            CGSize(width: width, height: 0) : CGSize(width: width, height: 460*scale)
        case FriendSection.FreindSearch.rawValue:
            return CGSize.zero
        case FriendSection.FriendList.rawValue:
            return CGSize.zero
        default:
            return CGSize.zero
        }
    }
}

extension FriendViewController {
    @objc func refreshCollectionView(_ sender: UIRefreshControl) {
        sender.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.showRequestPopView(isRefresh: true)
            self.cv?.setContentOffset(CGPoint.zero, animated: true)
        }
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
            tabModels.append(FriendTabModel(name: tabName1, badgeCount: friendBadgeCount))
            tabModels.append(FriendTabModel(name: tabName2, badgeCount: 100))
        case .FriendAndInvite:
            tabModels.append(FriendTabModel(name: tabName1, badgeCount: friendBadgeCount))
            tabModels.append(FriendTabModel(name: tabName2, badgeCount: 100))
        }
        friendTabHeader.updateWithData(models: tabModels)
        
        cv?.reloadData()
    }
}

extension FriendViewController: FriendUserHeaderDelegate {
    
}

extension FriendViewController: FriendTabHeaderDelegate {
    func friendTabTapped(index: Int) {
        print("friendTabTapped \(index)")
    }
}

extension FriendViewController: FriendListSearchHeaderDelegate {
    func searchFriendTextDidChange(text: String) {
        print("searchFriendTextDidChange :\(text)")
        friendViewModel.updateSearchText(text: text)
        
        let isFirstResponder = friendListSearchHeader?.searchBar?.isFirstResponder ?? false
        
        cv.performBatchUpdates({
            self.cv?.reloadSections(IndexSet(integer: FriendSection.FriendList.rawValue))
        }, completion: { isFinished in
//            self.friendListSearchHeader?.searchBar?.becomeFirstResponder()
        })
    }
    
    func seearcFriendBeginEdit() {
        print("seearcFriendBeginEdit")
        
        let section = FriendSection.FreindSearch.rawValue
        let indexPath = IndexPath(item: 0, section: section)
        if let attributes = cv.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: section)) {
            cv.setContentOffset(CGPoint(x: 0, y: attributes.frame.origin.y - cv.contentInset.top), animated: true)
        }
    }
}

extension FriendViewController: FriendEmptybFooterDelegate {
    
}

extension FriendViewController {
    func showRequestPopView(isRefresh: Bool = false) {
        let alertController = UIAlertController(title: "Request Options", message: "", preferredStyle: .alert)
        
        let action1 = UIAlertAction(title: "Without Friend", style: .default) { action in
            print("Button 1 tapped")
            self.requestFriendType = .NoFriend
            self.requestAPIs(isRefresh: isRefresh)
        }
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: "Friend List Only", style: .default) { action in
            self.requestFriendType = .FriendWithMixedSource
            self.requestAPIs(isRefresh: isRefresh)
        }
        alertController.addAction(action2)
        
        let action3 = UIAlertAction(title: "Friend List & Invite List", style: .default) { action in
            self.requestFriendType = .FriendAndInvite
            self.requestAPIs(isRefresh: isRefresh)
        }
        alertController.addAction(action3)
        
        present(alertController, animated: true, completion: nil)
    }
}
