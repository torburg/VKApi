//
//  PostListViewCell.swift
//  VKApi
//
//  Created by Maksim Torburg on 31.07.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class PostListViewCell: UITableViewCell {
    
    static let reuseIdentifier = "post"
    
    var avatar = UIImage()
    var title = UILabel()
    var dateLabel = UILabel()
    var photo = UIImage()
    var content = UITextField()
    var likesAmount = UILabel()
    var commentAmount = UILabel()
    var repostAmount = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func obtainPost(post: Post) {
        if let avatarURL = post.avatar {
            NetworkManager.shared.getImageData(from: avatarURL, completion: { (data) in
                if data != nil, let image = UIImage(data: data!) {
                    self.avatar = image
                }
            })
        }
        if let titleText = post.title {
            title.text = titleText
        }
        if let date = post.date {
            dateLabel.text = date.toStringFormatted()
        }
        if let photoURL = post.photo {
            NetworkManager.shared.getImageData(from: photoURL, completion: { (data) in
                if data != nil, let photo = UIImage(data: data!) {
                    self.photo = photo
                }
            })
        }
        if let contentText = post.content {
            content.text = contentText
        }
        likesAmount.text = String(post.likesAmount)
        commentAmount.text = String(post.commentAmount)
        repostAmount.text = String(post.repostAmount)
    }

}
