//
//  FavoriteViewDataSource.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/25.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit

final class FavoriteViewDataSource: NSObject {
    fileprivate let presenter: FavoritePresenter
    
    init(presenter: FavoritePresenter) {
        self.presenter = presenter
    }
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryViewCell.self)
    }
}

extension FavoriteViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfFavorites
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RepositoryViewCell.self, for: indexPath)
        let repository = presenter.favoriteRepository(at: indexPath.row)
        cell.configure(with: repository)
        return cell
    }
}

extension FavoriteViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.showFavoriteRepository(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let repository = presenter.favoriteRepository(at: indexPath.row)
        return RepositoryViewCell.calculateHeight(with: repository, and: tableView)
    }
}
