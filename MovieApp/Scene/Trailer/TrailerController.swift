//
//  TrailerController.swift
//  MovieApp
//
//  Created by Elnur Mammadov on 13.02.25.
//

import UIKit
import YouTubeiOSPlayerHelper

class TrailerController: UIViewController {
    
    var videoKey: String?
    
//    MARK: UI elements
    
    private lazy var webView: YTPlayerView = {
        let v = YTPlayerView()
        v.backgroundColor = .gray
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
//    MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.load(withVideoId: videoKey ?? "")
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}
