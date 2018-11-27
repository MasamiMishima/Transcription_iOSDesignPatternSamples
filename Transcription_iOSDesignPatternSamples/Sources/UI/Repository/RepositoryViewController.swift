//
//  RepositoryViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import SafariServices
import GithubKit

final class RepositoryViewController: SFSafariViewController {
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    private var favorites: [Repository] {
        return appDelegate?.favorites ?? []
    }
    
    private(set) lazy var favoriteButtonItem: UIBarButtonItem = {
        let favorites = self.favoriteHandlable?.getFavorites() ?? []
        let title = self.favorites.contains(where: { $0.url == self.repository.url }) ? "Remove" : "Add"
        return UIBarButtonItem(title: title,
                               style: .plain,
                               target: self,
                               action: #selector(RepositoryViewController.favoriteButtonTap(_:)))
    }()
    
    private let repository: Repository
    private weak var favoriteHandlable: FavoriteHandlable?
    
    init(repository: Repository,
         favoriteHandlable: FavoriteHandlable?,
         entersReaderIfAvailable: Bool = true) {
        self.repository = repository
        self.favoriteHandlable = favoriteHandlable
        super.init(url: repository.url, entersReaderIfAvailable: entersReaderIfAvailable)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favoriteButtonItem
    }
    
    @objc private func favoriteButtonTap(_ sender: UIBarButtonItem) {
        var favorites = favoriteHandlable?.getFavorites() ?? []
        if let index = favorites.index(where: {$0.url == repository.url}) {
            favorites.remove(at: index)
            favoriteButtonItem.title = "Add"
        } else {
            favorites.append(repository)
            favoriteButtonItem.title = "Remove"
        }
        favoriteHandlable?.setFavorites(favorites)
    }
}
