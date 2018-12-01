//
//  FavoriteViewModel.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/12/01.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit
import RxSwift
import RxCocoa

final class FavoriteViewModel {
    let favorites: Observable<[Repository]>
    let relaodData: Observable<Void>
    let selectedRepository: Observable<Repository>
    fileprivate let _favorites = BehaviorRelay<[Repository]>(value: [])
    private let disposeBag = DisposeBag()
    init(favoritesObservable: Observable<[Repository]>,
         selectedIndexPath: Observable<IndexPath>) {
        self.favorites = _favorites.asObservable()
        self.relaodData = _favorites.asObservable().map { _ in }
        self.selectedRepository = selectedIndexPath
            .withLatestFrom(_favorites.asObservable()) { $1[$0.row] }
        favoritesObservable
            .bind(to: _favorites)
            .disposed(by: disposeBag)
    }
}
extension FavoriteViewModel: ValueCompatible {}
extension Value where Base == FavoriteViewModel {
    var favorites: [Repository] {
        return base._favorites.value
    }
}
