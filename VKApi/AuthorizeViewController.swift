//
//  AuthorizeViewController.swift
//  VKApi
//
//  Created by Maksim Torburg on 30.07.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class AuthorizeViewController: UIViewController {

    var authorizeButton: UIButton!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAuthorizeButtonLayout()
    }
    
    // MARK: - Layouts
    private func setAuthorizeButtonLayout() {
        authorizeButton = UIButton()
        authorizeButton.setTitle("Authorize", for: .normal)
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorizeButton)
        let constraints = [
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            authorizeButton.heightAnchor.constraint(equalToConstant: 50),
            authorizeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let authorizeTap = UITapGestureRecognizer(target: self, action: #selector(authorizeTapped))
        authorizeButton.gestureRecognizers = [authorizeTap]
    }
    
    @objc
    func authorizeTapped() {
        networkManager.authorize()
    }
}
