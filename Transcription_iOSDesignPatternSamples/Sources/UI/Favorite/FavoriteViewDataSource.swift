//
//  FavoriteViewDataSource.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/25.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit

final class FavoriteVireDataSource: NSObject {
    var favorites: () -> [Repository]
    let selectedFavorite: (Repository) -> ()
    
    init(favorites: @escaping () -> [Repository], selectedFavorite: @escaping (Repository) -> ()) {
        self.favorites = favorites
        self.selectedFavorite = selectedFavorite
        super.init()
    }
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(RepositoryViewCell.self)
    }
}

extension FavoriteVireDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(RepositoryViewCell.self, for: indexPath)
        cell.configure(with: favorites()[indexPath.row])
        return cell
    }
}

extension FavoriteVireDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let repository = favorites()[indexPath.row]
        selectedFavorite(repository)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RepositoryViewCell.calculateHeight(with: favorites()[indexPath.row], and: tableView)
    }
}
