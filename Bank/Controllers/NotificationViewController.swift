//
//  NotificationViewController.swift
//  Bank
//
//  Created by Ian Fan on 2024/6/9.
//

import Foundation
import UIKit

class NotificationViewController: UIViewController {
    let scale: CGFloat = UIFactory.getScale()
    weak var messageViewModel: MessageViewModel!
    var cv: UICollectionView!
    var refreshControl: UIRefreshControl!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }
    
    init(messageViewModel: MessageViewModel) {
        self.messageViewModel = messageViewModel
        super.init(nibName: nil, bundle: nil)
        messageViewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = ColorEnum.localWhite2.color
        messageViewModel.delegate = self
        
        // navigation
        let nb = CustomNavigationView(frame: .zero)
        nb.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nb)
        
        // collectionview
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        cv.register(NotificationCell.self, forCellWithReuseIdentifier: NotificationCell.cellID)
        cv.delegate = messageViewModel
        cv.dataSource = messageViewModel
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        view.addSubview(cv)
        self.cv = cv
        
        // pull refresh
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = ColorEnum.systemGray10.color
        refreshControl.addTarget(self, action: #selector(refreshCollectionView(_:)), for: .valueChanged)
        cv.refreshControl = refreshControl
        self.refreshControl = refreshControl
        
        // layout
        NSLayoutConstraint.activate([
            nb.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nb.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nb.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nb.heightAnchor.constraint(equalToConstant: 48*scale),
            
            cv.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cv.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cv.topAnchor.constraint(equalTo: nb.bottomAnchor),
            cv.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // action
        nb.btnBackAction = { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }
    }
}

extension NotificationViewController {
    @objc func refreshCollectionView(_ sender: UIRefreshControl) {
        messageViewModel?.loadData(isRefresh: true)
        refreshControl?.endRefreshing()
    }
}

extension NotificationViewController: MessageViewModelProtocol {
    func updateMessageUI() {
        cv?.reloadData()
    }
}
