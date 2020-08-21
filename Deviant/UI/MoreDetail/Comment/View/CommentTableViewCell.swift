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
    private enum Const {
        static let imageWidth: CGFloat = 24
        static let leftMargin: CGFloat = 16
        static let topMargin: CGFloat = 8
    }

    private lazy var avatarImageView = UIImageView()

    private lazy var usernameLabel = UILabel.make( color: .white,
                                                   font: DeviFont.systemFont.semiBold(size: .body),
                                                   alignment: .left)
    private lazy var postDateLabel = UILabel.make( color: .lightText,
                                                   font: DeviFont.systemFont.font(size: .caption),
                                                   alignment: .right)
    private lazy var commentLabel = UILabel.make( color: .white,
                                                  font: DeviFont.systemFont.font(size: .caption),
                                                  numOfLines: 0,
                                                  alignment: .left)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    private func makeViews() {
        contentView.backgroundColor = .defaultBackground
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(postDateLabel)
        addSubview(commentLabel)
    }

    private func applyConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.leftMargin)
            make.top.equalToSuperview().offset(Const.topMargin)
            make.width.equalTo(Const.imageWidth)
            make.height.equalTo(Const.imageWidth)
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Const.leftMargin)
            make.top.equalTo(avatarImageView.snp.top)
            make.trailing.greaterThanOrEqualTo(postDateLabel.snp.leading).offset(Const.leftMargin)
        }
        postDateLabel.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImageView.snp.centerY)
            make.trailing.equalToSuperview().offset(-Const.leftMargin)
        }
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.equalTo(postDateLabel.snp.trailing)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Const.topMargin)
            make.bottom.equalToSuperview().offset(-Const.topMargin)
        }
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
