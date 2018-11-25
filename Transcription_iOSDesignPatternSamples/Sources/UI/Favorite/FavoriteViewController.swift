//
//  FavoriteViewController.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by Masami Mishima on 2018/11/17.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit

final class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var favorites: [Repository] {
        return (UIApplication.shared.delegate as? AppDelegate)?.favorites ?? []
    }
    
    private(set) lazy var detasource: FavoriteVireDataSource = {
        return .init(favorites: { [weak self] in
            return self?.favorites ?? []
            }, selectedFavorite: { [weak self] repository in
                self?.showRepository(with: repository)
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "On Memory Favorite"
        automaticallyAdjustsScrollViewInsets = false
        
        detasource.configure(with: tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    private func showRepository(with repository: Repository) {
        let vc = RepositoryViewController(repository: repository)
        navigationController?.pushViewController(vc, animated: true)
    }
}
