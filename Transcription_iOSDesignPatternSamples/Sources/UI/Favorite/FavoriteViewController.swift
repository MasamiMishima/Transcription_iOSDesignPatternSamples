//
//  FavoriteViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit
import RxSwift
import RxCocoa

protocol FavoriteView: class {
    func reloadData()
    func showRepository(with repository: Repository)
}

final class FavoriteViewController: UIViewController, FavoriteView {
    @IBOutlet weak var tableView: UITableView!
    
    private(set) lazy var presenter: FavoritePresenter = FavoriteViewPresenter(view: self)
    private lazy var dataSource: FavoriteViewDataSource = .init(presenter: self.presenter)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "On Memory Favorite"
        automaticallyAdjustsScrollViewInsets = false
        
        dataSource.configure(with: tableView)
    }
    
    func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository, favoritePresenter: presenter)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        tableView?.reloadData()
    }
}
