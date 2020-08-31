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
import RxSwift
import RxCocoa

final class RepositoryViewController: SFSafariViewController {
    private let favoriteButtonItem: UIBarButtonItem
    private let disposeBag = DisposeBag()
    private let viewModel: RepositoryViewModel
    
    init(repository: Repository,
         favoritesOutput: Observable<[Repository]>,
         favoritesInput: AnyObserver<[Repository]>,
         entersRederIfAvailable: Bool = true) {
        let favoriteButtonItem = UIBarButtonItem(
            title: nil, style: .plain, target: nil, action: nil)
        self.favoriteButtonItem = favoriteButtonItem
        self.viewModel = RepositoryViewModel(
            repository: repository,
            favoritesOutput: favoritesOutput,
            favoritesInput: favoritesInput,
            favoriteButtonTap: favoriteButtonItem.rx.tap)
        
        super.init(url: repository.url,
                   entersReaderIfAvailable: entersRederIfAvailable)
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = favoriteButtonItem
        viewModel.favoriteButtonTitle
        .bind(to: favoriteButtonItem.rx.title)
        .disposed(by: disposeBag)
    }
}
