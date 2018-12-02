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

protocol FavoriteHandlable: class {
    func getFavorites() -> [Repository]
    func setFavorites(_ repositories: [Repository])
}

final class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoritesInput: AnyObserver<[Repository]> { return favorites.asObserver() }
    var favoritesOutput: Observable<[Repository]> { return viewModel.favorites }
    
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
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryViewCell.self)
    }
    
    private func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository,
                                          favoriteHandlable: self)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoriteViewController: FavoriteHandlable {
    func getFavorites() -> [Repository] {
        return favorites
    }
    
    func setFavorites(_ repositories: [Repository]) {
        favorites = repositories
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RepositoryViewCell.self, for: indexPath)
        cell.configure(with: favorites[indexPath.row])
        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let repository = favorites[indexPath.row]
        showRepository(with: repository)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryViewCell.calculateHeight(with: favorites[indexPath.row], and: tableView)
    }
}
