//
//  DailyTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

class DailyTableViewCell: UITableViewCell {
    private enum Const {
        static let margin: CGFloat = 16
        static let interval: CGFloat = 12
        static let smallInterval: CGFloat = 6
        static let avatarImageWidth: CGFloat = 40
        static let starImageWidth: CGFloat = 16
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeViews()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var avatarImageView = UIImageView(image: UIImage(named: "commentAvatar"))
    private lazy var srcImageView = UIImageView()
    private lazy var loadingImageView = UIImageView(image: UIImage(named: "bigLoading"))
    private lazy var starImageView = UIImageView(image: UIImage(named: "starWhite"))
    private lazy var commentImageView = UIImageView(image: UIImage(named: "commentWhite"))

    private lazy var usernameLabel = UILabel.make(color: .white,
                                                  font: UIFont.headlineFont(),
                                                  alignment: .left)
    private lazy var titleLabel = UILabel.make(color: .white,
                                               font: UIFont.headlineFont(),
                                               alignment: .left)
    private lazy var timeLabel = UILabel.make(color: .white,
                                              font: UIFont.footnoteFont())
    private lazy var starsLabel = UILabel.make(color: .white,
                                               font: UIFont.footnoteFont())
    private lazy var commentLabel = UILabel.make(color: .white,
                                                 font: UIFont.footnoteFont(),
                                                 alignment: .left)

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    deinit {
        print(#function)
    }
}

extension DailyTableViewCell {
    func makeViews() {
        contentView.backgroundColor = UIColor.defaultBackground
        contentView.addSubview(avatarImageView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(loadingImageView)
        contentView.addSubview(srcImageView)
        contentView.addSubview(starImageView)
        contentView.addSubview(starsLabel)
        contentView.addSubview(commentImageView)
        contentView.addSubview(commentLabel)
        timeLabel.setContentHuggingPriority(.required, for: .horizontal)
        srcImageView.contentMode = .scaleAspectFit
    }

    func applyConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Const.margin)
            make.leading.equalToSuperview().offset(Const.margin)
            make.width.equalTo(Const.avatarImageWidth)
            make.height.equalTo(Const.avatarImageWidth)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Const.interval)
            make.trailing.equalToSuperview().offset(-Const.margin)
        }
        usernameLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(Const.interval)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(usernameLabel.snp.trailing).offset(Const.interval)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.centerY.equalTo(usernameLabel.snp.centerY)
        }
        srcImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(Const.margin)
            make.trailing.equalToSuperview().offset(-Const.margin)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Const.interval)
            make.height.equalTo(srcImageView.snp.width)
        }
        loadingImageView.snp.makeConstraints { make in
            make.center.equalTo(srcImageView.snp.center)
            make.width.equalTo(Const.starImageWidth)
            make.height.equalTo(loadingImageView.snp.width)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.leading)
            make.width.equalTo(Const.starImageWidth)
            make.height.equalTo(Const.starImageWidth)
        }
        starsLabel.snp.makeConstraints { make in
            make.top.equalTo(srcImageView.snp.bottom).offset(Const.interval)
            make.bottom.equalToSuperview().offset(-Const.margin)
            make.centerY.equalTo(starImageView.snp.centerY)
            make.leading.equalTo(starImageView.snp.trailing).offset(Const.smallInterval)
        }
        commentImageView.snp.makeConstraints { make in
            make.leading.equalTo(starsLabel.snp.trailing).offset(Const.interval)
            make.centerY.equalTo(starsLabel.snp.centerY)
            make.width.equalTo(Const.starImageWidth)
            make.height.equalTo(Const.starImageWidth)
        }
        commentLabel.snp.makeConstraints { make in
            make.leading.equalTo(commentImageView.snp.trailing).offset(Const.smallInterval)
            make.centerY.equalTo(commentImageView.snp.centerY)
        }
    }
}

extension DailyTableViewCell {
    private func setImageViewWhenFailure() {
        srcImageView.image = UIImage(named: "bigEmpty")
    }

    struct ViewData {
        var detail: DeviantDetailDisplayModel
        var identifier: AccessibilityIdentifier
        var row: Int
    }

    func update(with viewData: ViewData) {
        setupAccessibility(with: viewData)
        srcImageView.image = nil
        setAccessibilityIdentifier(viewData.identifier, row: viewData.row)

        let detail = viewData.detail

        if let usericon = detail.usericon,
            let url = URL(string: usericon) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "bigLoading"))
        } else {
            avatarImageView.image = UIImage(named: "commentAvatar")
        }

        usernameLabel.text = detail.username
        titleLabel.text = detail.title
        let publishedTime = String.getDateFromTimeStamp(with: detail.publishedTime ?? "")
        timeLabel.text = publishedTime
        starsLabel.text = "\(detail.favourites ?? 0)"
        commentLabel.text = "\(detail.comments ?? 0)"

        if URL(string: detail.previewImage?.src ?? "") != nil {
            setupSrcImageView(with: detail)
        } else {
            setImageViewWhenFailure()
        }
    }

    private func setupSrcImageView(with detail: DeviantDetailDisplayModel) {
        loadingImageView.isHidden = false
        let url = URL(string: detail.previewImage?.src ?? "")
        srcImageView.kf.setImage(with: url) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            strongSelf.loadingImageView.isHidden = true
            switch result {
            case .failure:
                strongSelf.setImageViewWhenFailure()
            default:
                break
            }
        }

        if let width = detail.previewImage?.width,
            let height = detail.previewImage?.height {
            let radio = CGFloat(height) / CGFloat(width)
            srcImageView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(Const.margin)
                make.trailing.equalToSuperview().offset(-Const.margin)
                make.top.equalTo(usernameLabel.snp.bottom).offset(Const.interval)
                make.height.equalTo(srcImageView.snp.width).multipliedBy(radio)
            }
        }
    }
}

extension DailyTableViewCell {
    private func setupAccessibility(with viewData: ViewData) {
        setAccessibilityIdentifier(viewData.identifier, row: viewData.row)

        let detail = viewData.detail

        var accessibilityText = "\(detail.title.wrap()) by \(detail.username.wrap()), "
        let publishedTime = String.getDateFromTimeStamp(with: detail.publishedTime ?? "")
        accessibilityText += "published at \(publishedTime), "
        let favourites = detail.favourites ?? 0
        if favourites > 0 {
            accessibilityText += "favorited at \(favourites), "
        }
        let comments = detail.comments ?? 0
        if comments > 0 {
            accessibilityText += "comments \(comments)"
        }
        accessibilityLabel = accessibilityText

        accessibilityElements = []
    }
}
