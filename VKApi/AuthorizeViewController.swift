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
    var appIDLabel: UITextField!
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAuthorizeButtonLayout()
        setAppIDLabelLayout()
    }
    
    // MARK: - Layouts
    private func setAuthorizeButtonLayout() {
        authorizeButton = UIButton()
        authorizeButton.setTitle("Authorize", for: .normal)
        authorizeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(authorizeButton)
        let constraints = [
            authorizeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            authorizeButton.heightAnchor.constraint(equalToConstant: 50),
            authorizeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5)
        ]
        NSLayoutConstraint.activate(constraints)
        
        let authorizeTap = UITapGestureRecognizer(target: self, action: #selector(authorizeTapped))
        authorizeButton.gestureRecognizers = [authorizeTap]
    }
    
    private func setAppIDLabelLayout() {
        appIDLabel = UITextField()
        appIDLabel.placeholder = "Application ID"
        appIDLabel.backgroundColor = .white
        appIDLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(appIDLabel)
        let constraints = [
            appIDLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appIDLabel.topAnchor.constraint(equalTo: authorizeButton.bottomAnchor, constant: 25),
            appIDLabel.heightAnchor.constraint(equalTo: authorizeButton.heightAnchor),
            appIDLabel.widthAnchor.constraint(equalTo: authorizeButton.widthAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc
    func authorizeTapped() {
        if appIDLabel.hasText {
            networkManager.authorize { response in
                switch response {
                case .success:
                    let viewController = MainListViewController()
                    viewController.modalPresentationStyle = .fullScreen
                    present(viewController, animated: true, completion: nil)
                case let error:
                    let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: "App ID cannot be empty", message: "Fill it please", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Close", style: .destructive, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
