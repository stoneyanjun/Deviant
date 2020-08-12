//
//  CommentTableViewCell.swift
//  Deviant
//
//  Created by Stone on 3/8/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
import UIKit

class CommentTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with viewData: ViewData) {
        if let avatarUrlString = viewData.avatarUrlString,
            let url = URL(string: avatarUrlString) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        } else {
            avatarImageView.image = UIImage(named: "commentAvatar")
        }

        usernameLabel.text = viewData.username
        postDateLabel.text = viewData.postedDate
        commentLabel.text = viewData.comment
    }
}

extension CommentTableViewCell {
    struct ViewData {
        var avatarUrlString: String?
        var username: String
        var postedDate: String
        var comment: String
    }
}
