//
//  FavoriteModel.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島 正三 on 2018/12/04.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation

@objc protocol FavoriteModelDeletgate: class {
    @objc optional func favoriteDidChange()
}

final class FavoriteModel {
    private(set) var favorites: [Repository] = [] {
        didSet {
            delegate?.favoriteDidChange?()
        }
    }
    
    weak var delegate: FavoriteModelDelegate?
    
    func addFavorite(_ repository: Repository) {
        if favorites.lazy.index(where: { $0.url == repository.url }) != nil {
            return
        }
        favorites.append(repository)
    }
    
    func removeFavorite(_ repository: Repository) {
        guard let index = favorites.lazy.index(where: { $0.url == repository.url }) else {
            return
        }
        favorites.remove(at: index)
    }
}
