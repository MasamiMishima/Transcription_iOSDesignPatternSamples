//
//  UserRepositoryViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit

protocol UserRepositoryView: class {
    func reloadData()
    func showRepository(with repository: Repository)
    func updateTotalCountLabel(_ countText: String)
    func updateLoadingView(with view: UIView, isLoading: Bool)
}

final class UserRepositoryViewController: UIViewController, UserRepositoryView {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    private let loadingView = LoadingView.makeFromNib()
    private let favoritePresenter: FavoritePresenter
    private let presenter: UserRepositoryPresenter
    
    private lazy var dataSource: UserRepositoryViewDataSource = .init(presenter: self.presenter)
    
    init(user: User, favoritePresenter: FavoritePresenter) {
        self.favoritePresenter = favoritePresenter
        self.presenter = UserRepositoryViewPresenter(user: user)
        super.init(nibName: UserRepositoryViewController.className, bundle: nil)
        hidesBottomBarWhenPushed = true
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = presenter.title
        edgesForExtendedLayout = []
        
        dataSource.configure(with: tableView)
        presenter.fetchRepositories()
    }
    
    func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository, favoritePresenter: favoritePresenter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func updateTotalCountLabel(_ countText: String) {
        totalCountLabel.text = countText
    }
    
    func updateLoadingView(with view: UIView, isLoading: Bool) {
        loadingView.removeFromSuperview()
        loadingView.isLoading = isLoading
        loadingView.add(to: view)
    }
}
