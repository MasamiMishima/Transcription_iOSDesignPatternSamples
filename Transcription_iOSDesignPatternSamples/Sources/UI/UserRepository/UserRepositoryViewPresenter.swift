//
//  UserRepositoryViewPresenter.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島 正三 on 2018/12/03.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import GithubKit

protocol UserRepositoryPresenter: class {
    init(user: User)
    weak var view: UserRepositoryView? { get set }
    var title: String { get }
    var isFetchingRepositories: Bool { get }
    var numberOfRepositories: Int { get }
    func repository(at index: Int) -> Repository
    func showRepository(at index: Int)
    func showLoadingView(on view: UIView)
    func setIsReachedBottom(_ isReachedBottom: Bool)
    func fetchRepositories()
}

