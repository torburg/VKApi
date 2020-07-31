//
//  MainListViewController.swift
//  VKApi
//
//  Created by Maksim Torburg on 30.07.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {
    
    var postList: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        setPostListtable()
    }
    
    func setPostListtable() {
        let frame = CGRect(origin: view.center, size: view.frame.size)
        postList = UITableView(frame: frame)
        postList.backgroundColor = .white
        postList.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(postList)
        let constraints = [
            postList.topAnchor.constraint(equalTo: view.topAnchor),
            postList.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            postList.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            postList.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }

}

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = postList.dequeueReusableCell(withIdentifier: "post", for: indexPath)
        return cell
    }
    
    
}
