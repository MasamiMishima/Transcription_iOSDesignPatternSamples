//
//  SearchViewDataSource.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/20.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import Foundation
import UIKit
import GithubKit
import RxSwift

final class SearchViewDataSource: NSObject {
    private let selectedIndexPath: AnyObserver<IndexPath>
    private let isReachedBottom: AnyObserver<Bool>
    private let headerFooterView: AnyObserver<UIView>
    
    private let viewModel: SearchViewModel
    
    init(viewModel: SearchViewModel,
         selectedIndexPath: AnyObserver<IndexPath>,
         isReachedBottom: AnyObserver<Bool>,
         headerFooterView: AnyObserver<UIView>) {
        self.viewModel = viewModel
        self.selectedIndexPath = selectedIndexPath
        self.isReachedBottom = isReachedBottom
        self.headerFooterView = headerFooterView
    }
    
    func configure(with tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UserViewCell.self)
        tableView.register(UITableViewHeaderFooterView.self,
                           forHeaderFooterViewReuseIdentifier: UITableViewHeaderFooterView.className)
    }
}

extension SearchViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.value.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(UserViewCell.self, for: indexPath)
        let user = viewModel.value.users[indexPath.row]
        cell.configure(with: user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: UITableViewHeaderFooterView.className) else {
            return nil
        }
        headerFooterView.onNext(view)
        return view
    }
}

extension SearchViewDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectedIndexPath.onNext(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let user = viewModel.value.users[indexPath.row]
        return UserViewCell.calculateHeight(with: user, and: tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.value.isFetchingUsers ? LoadingView.defaultHeight : .leastNormalMagnitude
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let maxScrollDistance = max(0, scrollView.contentSize.height - scrollView.bounds.size.height)
        isReachedBottom.onNext(maxScrollDistance <= scrollView.contentOffset.y)
    }
}
