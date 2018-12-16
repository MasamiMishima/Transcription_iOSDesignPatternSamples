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
    private(set) lazy var favoriteButtonItem: UIBarButtonItem = {
        let favorites = self.favoriteModel.favorites
        let title = favorites.contains(where: { $0.url == self.repository.url }) ? "Remove" : "Add"
        return UIBarButtonItem(title: title,
                               style: .plain,
                               target: self,
                               action: #selector(RepositoryViewController.favoriteButtonTap(_:)))
    }()
    
    private let repository: Repository
    private let favoriteModel: FavoriteModel
    
    init(repository: Repository,
         favoriteModel: FavoriteModel,
         entersReaderIfAvailable: Bool = true) {
        self.repository = repository
        self.favoriteModel = favoriteModel
        
        super.init(url: repository.url, entersReaderIfAvailable: entersReaderIfAvailable)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favoriteButtonItem
    }
    
    @objc private func favoriteButtonTap(_ sender: UIBarButtonItem) {
        if favoriteModel.favorites.index(where: { $0.url == repository.url }) == nil {
            favoriteModel.addFavorite(repository)
            favoriteButtonItem.title = "Remove"
        } else {
            favoriteModel.removeFavorite(repository)
            favoriteButtonItem.title = "Add"
        }
    }
}
