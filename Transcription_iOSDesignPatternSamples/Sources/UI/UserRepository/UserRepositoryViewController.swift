//
//  UserRepositoryViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit

class UserRepositoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    fileprivate let loadingView = LoadingView.makeFromNib()
    
    fileprivate var isReachdBottom: Bool = false {
        didSet {
            if isReachdBottom && isReachdBottom != oldValue {
                fetchRepositories()
            }
        }
    }
    private var isFetchingRepositories = false {
        didSet {
            tableView.reloadData()
        }
    }
    private var totalCount: Int = 0 {
        didSet {
            totalCountLabel.text = "\(repositories.count) / \(totalCount)"
            tableView.reloadData()
        }
    }
    fileprivate var repositories: [Repository] = []  {
        didSet {
            totalCountLabel.text = "\(repositories.count) / \(totalCount)"
            tableView.reloadData()
        }
    }
    private var pageInfo: PageInfo? = nil
    private var task: URLSessionTask? = nil
    
    private let user: User
//    private weak var favoriteHanflable: FavoriteHa
    
    init(user: User) {
        self.user = user
        super.init(nibName: UserRepositoryViewController.className, bundle: nil)
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(user.login)'s Repositories"
        edgesForExtendedLayout = []
        
        dataSource.configure(with: tableView)
        
        fetchRepositories()
    }
    private func fetchRepositories() {
        if task != nil { return }
        if let pageInfo = pageInfo, !pageInfo.hasNextPage || pageInfo.endCursor == nil { return }
        isFetchingRepositories = true
        let request = UserNodeRequest(id: user.id, after: pageInfo?.endCursor)
        self.task = ApiSession.shared.send(request) { [weak self] in
            switch $0 {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.pageInfo = value.pageInfo
                    self?.repositories.append(contentsOf: value.nodes)
                    self?.totalCount = value.totalCount
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.isFetchingRepositories = false
            }
            self?.task = nil
        }
    }
    
    private func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository)
        navigationController?.pushViewController(vc, animated: true)
    }
}
