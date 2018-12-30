//
//  RepositoryViewModel.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島 正三 on 2018/12/30.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit
import RxSwift
import RxCocoa

final class RepositoryViewModel {
    let favoriteButtonTitle: Observable<String>
    private let disposeBag = DisposeBag()
    
    init(repository: Repository,
         favoritesOutput: Observable<[Repository]>,
         favoritesInput: AnyObserver<[Repository]>,
         favoriteButtonTap: ControlEvent<Void>) {
        let favoritesAndIndex = favoritesOutput
            .map { ($0, $0.index { $0.url == repository.url }) }
            .share(replay: 1, scope: .whileConnected)
        
        self.favoriteButtonTitle = favoritesAndIndex
            .map { $0.1 == nil ? "Add" : "Remove" }
            .share(replay: 1, scope: .forever)
        
        favoriteButtonTap
            .withLatestFrom(favoritesAndIndex)
            .map { favorites, index in
                var favorites = favorites
                if let index = index {
                    favorites.remove(at: index)
                    return favorites
                }
                favorites.append(repository)
                return favorites
            }
            // to use ".concat(Observable.never())" because to avoid sending dispose
            .concat(Observable.never())
            .bind(to: favoritesInput)
            .disposed(by: disposeBag)
    }
}
