//
//  RepositoryViewPresenter.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/12/25.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit

protocol RepositoryPresenter: class {
    init(repository: Repository, favoritePresenter: FavoritePresenter)
    weak var view: RepositoryView? { get set }
    var favoriteButtonTitle: String { get }
    func favoriteButtonTap()
}

final class RepositoryViewPresenter: RepositoryPresenter {
    weak var view: RepositoryView?
    private let favoritePresenter: FavoritePresenter
    private let repository: Repository
    
    var favoriteButtonTitle: String {
        return favoritePresenter.contains(repository) ? "Remove" : "Add"
    }
    
    init(repository: Repository, favoritePresenter: FavoritePresenter) {
        self.repository = repository
        self.favoritePresenter = favoritePresenter
    }
    
    func favoriteButtonTap() {
        if favoritePresenter.contains(repository) {
            favoritePresenter.removeFavorite(repository)
            view?.updateFavoriteButtonTitle(favoriteButtonTitle)
        } else {
            favoritePresenter.addFavorite(repository)
            view?.updateFavoriteButtonTitle(favoriteButtonTitle)
        }
    }
}
