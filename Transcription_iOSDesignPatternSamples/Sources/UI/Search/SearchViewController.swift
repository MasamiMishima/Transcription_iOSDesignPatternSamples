//
//  SearchViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit
import NoticeObserveKit

class SearchViewController: UIViewController {

    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    private(self) lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = self
        return searchBar
    }()
    
    fileprivate var query: String = "" {
        didSet {
            if query != oldValue {
                users.removeAll()
                pageInfo = nil
                totalCount = 0
            }
            task?.cancel()
            task = nil
            fetchUsers()
        }
    }
    private var task: URLSessionTask? = nil
    private var pageInfo: PageInfo? = nil
    private var totalCount: Int = 0 {
        didSet {
            totalCountLabel.text = "\(users.count) / \(totalCount)"
        }
    }
    private var users: [User] = [] {
        didSet {
            totalCountLabel.text = "\(users.count) / \(totalCount)"
            tableView.reloadData()
        }
    }
    private(set) lazy var dataSource: SearchViewDataSource = {
        return .init(fetchUsers: { [weak self] in
            self?.fetchUsers()
        }, isFechingUsers: { [weak self] in
            return self?.isFetchingUsers ?? false
        }, users: { [weak self] in
            self?.users ?? []
        }, selectedUser: { [weak self] user in
        
        })
    }()
    
    private var isFetchingUsers = false {
        didSet {
            tableView.reloadData()
        }
    }
    
    private func fetchUsers() {
        if query.isEmpty || task != nil { return }
        if let pageInfo = pageInfo, !pageInfo.hasNextPage || pageInfo.endCursor == nil { return }
        isFetchingUsers = true
        let request = SearchUserRequest(query: query, after: pageInfo?.endCursor)
        self.task = ApiSession.shared.send(request) { [weak self] in
            switch $0 {
            case .success(let value):
                DispatchQueue.main.async {
                    self?.pageInfo = value.pageInfo
                    self?.users.append(contentsOf: value.nodes)
                    self?.totalCount = value.totalCount
                }
            case .failure(let error):
                print(error)
            }
            DispatchQueue.main.async {
                self?.isFetchingUsers = false
            }
            self?.task = nil
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        debounce { [weak self] in
            self?.query = searchText
        }
    }
}
