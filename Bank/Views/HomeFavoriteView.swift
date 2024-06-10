//
//  HomeFavorite.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class HomeFavoriteView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var favoriteViewModel: FavoriteViewModel!
    
    var lbTitle: UILabel!
    var lbMore: UILabel!
    var ivMore: UIImageView!
    var btnMore: UIButton!
    var emptyView: HomeFavoriteEmptyView!
    var cv: UICollectionView!
    
    init(frame: CGRect, favoriteViewModel: FavoriteViewModel) {
        super.init(frame: frame)
        self.favoriteViewModel = favoriteViewModel
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let topContainer = UIFactory.createView(color: .clear)
        let lbTitle = UIFactory.createLabel(size: 18*scale, text: "My Favorite".localized(), color: ColorEnum.systemGray5.color, font: .SFProTextHeavy)
        let lbMore = UIFactory.createLabel(size: 16*scale, text: "More".localized(), color: ColorEnum.systemGray7.color, font: .SFProTextRegular)
        let ivMore = UIFactory.createImage(name: "iconArrow01Next")
        let btnMore = UIFactory.createImageButton(name: "")
        
        addSubview(topContainer)
        addSubview(lbTitle)
        addSubview(lbMore)
        addSubview(ivMore)
        addSubview(btnMore)
        
        self.lbTitle = lbTitle
        self.lbMore = lbMore
        self.ivMore = ivMore
        self.btnMore = btnMore
        
        let margin = 24*scale
        NSLayoutConstraint.activate([
            topContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            topContainer.topAnchor.constraint(equalTo: topAnchor),
            topContainer.heightAnchor.constraint(equalToConstant: 48*scale),
            
            lbTitle.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            lbTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin),
            lbTitle.heightAnchor.constraint(equalToConstant: 24*scale),
            
            ivMore.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            ivMore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16*scale),
            ivMore.widthAnchor.constraint(equalToConstant: 24*scale),
            ivMore.heightAnchor.constraint(equalToConstant: 24*scale),
            
            lbMore.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor),
            lbMore.trailingAnchor.constraint(equalTo: ivMore.leadingAnchor),
            
            btnMore.topAnchor.constraint(equalTo: topContainer.topAnchor),
            btnMore.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor),
            btnMore.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16*scale),
            btnMore.widthAnchor.constraint(equalToConstant: 76*scale),
        ])
        
        let emptyView = HomeFavoriteEmptyView()
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        self.emptyView = emptyView
        addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.leadingAnchor.constraint(equalTo: leadingAnchor),
            emptyView.trailingAnchor.constraint(equalTo: trailingAnchor),
            emptyView.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            emptyView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        // collectionview
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.cellID)
        cv.delegate = self
        cv.dataSource = favoriteViewModel
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.contentInset = UIEdgeInsets(top: 0, left: 24*scale, bottom: 0, right: 24*scale)
        addSubview(cv)
        self.cv = cv
        cv.alpha = 0
        NSLayoutConstraint.activate([
            cv.leadingAnchor.constraint(equalTo: leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: trailingAnchor),
            cv.topAnchor.constraint(equalTo: topContainer.bottomAnchor),
            cv.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func updateWithViewModel() {
        if favoriteViewModel.favorites.isEmpty {
            emptyView?.alpha = 1
            cv?.alpha = 0
        } else {
            emptyView?.alpha = 0
            cv?.alpha = 1
            cv?.reloadData()
        }
    }
}

extension HomeFavoriteView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectSectionIndex = indexPath.section
        let selectIndex = indexPath.item
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FavoriteCell, let obj: HomeFavoriteModel = cell.favorite else {
            return
        }
    }
}

extension HomeFavoriteView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height
        let size = CGSize(width: 80*scale, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

class HomeFavoriteEmptyView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var ivIcon: UIImageView!
    var lbDes: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        let ivIcon = UIFactory.createImage(name: "button00ElementScrollEmpty", corner: 28*scale)
        let lbDes = UIFactory.createLabel(size: 14*scale, text: "You can add a favorite through the transfer or payment function.".localized(), color: ColorEnum.systemGray6.color, font: .SFProTextRegular)
        
        self.ivIcon = ivIcon
        self.lbDes = lbDes
        
        addSubview(ivIcon)
        addSubview(lbDes)
        
        lbDes.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            ivIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8*scale),
            ivIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 36*scale),
            ivIcon.widthAnchor.constraint(equalToConstant: 56*scale),
            ivIcon.heightAnchor.constraint(equalToConstant: 56*scale),
            
            lbDes.centerYAnchor.constraint(equalTo: ivIcon.centerYAnchor),
            lbDes.leadingAnchor.constraint(equalTo: ivIcon.trailingAnchor, constant: 12*scale),
            lbDes.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24*scale),
        ])
    }
}
