//
//  LoadingView.swift
//  Transcription_iOSDesignPatternSamples
//
//  Created by 三島正三 on 2018/11/19.
//  Copyright © 2018 Masami Mishima. All rights reserved.
//

import UIKit
import GithubKit

final class LoadingView: UIView, Nibable {
    typealias RegisterType = RegisterNib
    
    static let defaultHeight: CGFloat = 44
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var isLoading: Bool = false {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let me = self else { return }
                me.activityIndicator?.isHidden = !me.isLoading
                if me.isLoading {
                    me.activityIndicator?.startAnimating()
                } else {
                    me.activityIndicator?.stopAnimating()
                }
            }
        }
    }
    
    func add(to view: UIView) {
        removeFromSuperview()
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leftAnchor.constraint(equalTo: leftAnchor),
            view.rightAnchor.constraint(equalTo: rightAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
