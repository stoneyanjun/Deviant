//
//  CommentTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import Reusable
import UIKit

class CommentTableViewCell: UITableViewCell, Reusable {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!

//    private lazy var usernameLabel = UILabel.make( color: .white,
//                                                            backgroundColor: .defaultBackground,
//                                                            font: DeviFont.systemFont.font(size: .body),
//                                                            numOfLines: 0,
//                                                            alignment: .left)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }

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
    private func makeViews() {

    }

    private func applyConstraints() {

    }
}
extension CommentTableViewCell {
    struct ViewData {
        var avatarUrlString: String?
        var username: String
        var postedDate: String
        var comment: String
        var commentId: String?
    }
}
