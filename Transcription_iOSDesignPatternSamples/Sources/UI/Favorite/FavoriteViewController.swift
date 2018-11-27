//
//  FavoriteViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit

protocol FavoriteHandlable: class {
    func getFavorites() -> [Repository]
    func setFavorites(_ repositories: [Repository])
}

final class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var favorites: [Repository] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "On Memory Favorite"
        automaticallyAdjustsScrollViewInsets = false
        
        configure(with: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func configure(with tableView: UITableView) {
         let vc = RepositoryViewController(repository: repository, favoriteHandlable: self)
        tableView.delegate = self
        
        tableView.register(RepositoryViewCell.self)
    }
    
    private func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository,
                                          entersReaderIfAvailable: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
