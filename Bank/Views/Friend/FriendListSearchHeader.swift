//
//  FriendListSearchHeader.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/11.
//

import Foundation
import UIKit

protocol FriendListSearchHeaderDelegate: AnyObject {
    func searchFriendTextDidChange(text: String)
    func seearcFriendBeginEdit()
}

class FriendListSearchHeader: UICollectionReusableView {
    static let headerID = "FriendListSearchHeader"

    weak var delegate: FriendListSearchHeaderDelegate?
    let scale: CGFloat = UIFactory.getScale()
    
    var searchBar: UISearchBar!
    var btnAddFriend: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("prepareForReuse")
    }
    
    func setupUI() {
        backgroundColor = ColorFactory.white3
        
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        let btnAddFriend = UIFactory.createImageButton(name: "icBtnAddFriends")
        
        self.searchBar = searchBar
        self.btnAddFriend = btnAddFriend
        
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        let textField = searchBar.searchTextField
        textField.backgroundColor = UIColor(hexString: "#F1F1F2")
        
        // text color
        textField.textColor = ColorFactory.steel
        
        // placeholder color
        textField.attributedPlaceholder = NSAttributedString(
            string: "想轉一筆給誰呢？".localized(),
            attributes: [
                .foregroundColor: ColorFactory.steel,
                .font: UIFont(name: FontEnum.PingFangTCRegular.rawValue, size: 14*scale) ?? UIFont.systemFont(ofSize: 14*scale)
            ]
        )

        // corner
        textField.layer.cornerRadius = 10*scale
        textField.layer.masksToBounds = true

        // left magnifier image
        if let leftView = textField.leftView as? UIImageView {
            leftView.image = UIImage(named: "icSearchBarSearchGray")?.withRenderingMode(.alwaysTemplate)
            leftView.tintColor = ColorFactory.steel
        }
        
        // clear button
        searchBar.setImage(UIFactory.getImage(named: "x.circle")?.imageWithColor(ColorFactory.steel), for: .clear, state: .normal)
//        textField.clearButtonMode = .never
        
        btnAddFriend.addTarget(self, action: #selector(btnAddFriendTapped), for: .touchUpInside)
        
        addSubview(searchBar)
        addSubview(btnAddFriend)
        
        NSLayoutConstraint.activate([
            searchBar.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30*scale),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -69*scale),
            searchBar.heightAnchor.constraint(equalToConstant: 36*scale),
            
            btnAddFriend.centerYAnchor.constraint(equalTo: centerYAnchor),
            btnAddFriend.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30*scale),
            btnAddFriend.widthAnchor.constraint(equalToConstant: 24*scale),
            btnAddFriend.heightAnchor.constraint(equalToConstant: 24*scale),
        ])
            
    }
    
    @objc func btnAddFriendTapped() {
        
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        searchBar?.resignFirstResponder()
        return false
    }
}

extension FriendListSearchHeader: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Search text: \(searchText)")
        
        self.delegate?.searchFriendTextDidChange(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Search button clicked")
        searchBar.resignFirstResponder()
        
//        if let text = searchBar.text, !text.isEmpty {
//            self.delegate?.searchFriendTextDidChange(text: text)
//        }
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancel button clicked")
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidBeginEditing")
    }

    // UISearchBarDelegate 方法 - 使用者結束編輯文字時調用
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("searchBarTextDidEndEditing")
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldEndEditing")
        return true
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("searchBarShouldBeginEditing")
        self.delegate?.seearcFriendBeginEdit()
        return true
    }
}

