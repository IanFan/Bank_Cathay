//
//  HomeAdView.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class HomeAdView: UIView {
    let scale: CGFloat = UIFactory.getScale()
    var adBannerViewModel: AdBannerViewModel!
    var cv: UICollectionView!
    var pageControl: UIPageControl!
    var timer: Timer?
    var currentIndex = 0
    
    deinit {
        print("\(type(of: self)) deinit")
        stopAutoScroll()
    }
    
    init(frame: CGRect, adBannerViewModel: AdBannerViewModel) {
        super.init(frame: frame)
        self.adBannerViewModel = adBannerViewModel
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupViews()
    }
    
    private func setupViews() {
        // collectionview
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.register(AdCell.self, forCellWithReuseIdentifier: AdCell.cellID)
        cv.delegate = self
        cv.dataSource = adBannerViewModel
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        cv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        addSubview(cv)
        self.cv = cv
        NSLayoutConstraint.activate([
            cv.leadingAnchor.constraint(equalTo: leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: trailingAnchor),
            cv.topAnchor.constraint(equalTo: topAnchor),
            cv.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20*scale),
        ])
        
        // pageControl
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = adBannerViewModel.adBanners.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlValueChanged), for: .valueChanged)
        addSubview(pageControl)
        self.pageControl = pageControl
        NSLayoutConstraint.activate([
            pageControl.leadingAnchor.constraint(equalTo: leadingAnchor),
            pageControl.trailingAnchor.constraint(equalTo: trailingAnchor),
            pageControl.topAnchor.constraint(equalTo: cv.bottomAnchor),
            pageControl.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    func updateWithViewModel() {
        guard !adBannerViewModel.adBanners.isEmpty else {
            return
        }
        
        currentIndex = max(min(currentIndex, adBannerViewModel.adBanners.count-1), 0)
        
        pageControl?.numberOfPages = adBannerViewModel.adBanners.count
        pageControl?.currentPage = currentIndex
        
        cv?.reloadData()
        startAutoScroll()
    }
    
    @objc func pageControlValueChanged(sender: UIPageControl) {
        let currentPage = sender.currentPage
        let offsetX = CGFloat(currentPage) * cv.frame.width
        let contentOffset = CGPoint(x: offsetX, y: 0)
        cv?.setContentOffset(contentOffset, animated: true)
        self.currentIndex = currentPage
        
        startAutoScroll()
    }
}

extension HomeAdView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectSectionIndex = indexPath.section
        let selectIndex = indexPath.item
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? AdCell, let obj: HomeAdModel = cell.adModel else {
            return
        }
    }
}

extension HomeAdView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout _: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let height = 88*scale
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension HomeAdView: UIScrollViewDelegate {
    @objc func autoScroll() {
        guard !adBannerViewModel.adBanners.isEmpty else {
            stopAutoScroll()
            return
        }
        if currentIndex < (adBannerViewModel.adBanners.count - 1) {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        cv.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    func startAutoScroll() {
        stopAutoScroll()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentIndex = pageIndex
        pageControl.currentPage = pageIndex
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopAutoScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startAutoScroll()
    }
}
