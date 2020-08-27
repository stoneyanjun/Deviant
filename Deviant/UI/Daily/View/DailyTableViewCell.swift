//
//  DailyTableViewCell.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Kingfisher
import Reusable
import SnapKit
import UIKit

class DailyTableViewCell: UITableViewCell, Reusable {
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
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.top)
            make.leading.equalTo(avatarImageView.snp.trailing).offset(Const.interval)
            make.trailing.equalToSuperview().offset(-Const.margin)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(usernameLabel.snp.bottom).offset(Const.interval)
        }
        timeLabel.snp.makeConstraints { make in
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(Const.interval)
            make.trailing.equalTo(usernameLabel.snp.trailing)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        srcImageView.snp.makeConstraints { make in
            make.leading.equalTo(avatarImageView.snp.leading)
            make.trailing.equalTo(timeLabel.snp.trailing)
            make.top.equalTo(titleLabel.snp.bottom).offset(Const.interval)
            make.height.equalTo(srcImageView.snp.width)
        }
        loadingImageView.snp.makeConstraints { make in
            make.center.equalTo(srcImageView.snp.center)
            make.width.equalTo(Const.starImageWidth)
            make.height.equalTo(loadingImageView.snp.width)
        }
        starImageView.snp.makeConstraints { make in
            make.leading.equalTo(srcImageView.snp.leading)
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
    func update(with result: DeviantDetailBase) {
        if let usericon = result.author?.usericon,
            let url = URL(string: usericon) {
            avatarImageView.kf.setImage(with: url, placeholder: UIImage(named: "bigLoading"))
        } else {
            avatarImageView.image = UIImage(named: "commentAvatar")
        }

        usernameLabel.text = result.author?.username
        titleLabel.text = result.title
        let resultTxt = String.getDateFromTimeStamp(with: result.publishedTime ?? "")
        timeLabel.text = resultTxt

        if let width = result.preview?.width,
            let height = result.preview?.height {
            let radio = CGFloat(height) / CGFloat(width)
            srcImageView.snp.remakeConstraints { make in
                make.leading.equalToSuperview().offset(Const.margin)
                make.trailing.equalToSuperview().offset(-Const.margin)
                make.top.equalTo(titleLabel.snp.bottom).offset(Const.interval)
                make.height.equalTo(srcImageView.snp.width).multipliedBy(radio)
            }
        }

        loadingImageView.isHidden = false
        if let src = result.preview?.src ,
            let url = URL(string: src) {
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
        } else {
            setImageViewWhenFailure()
        }
        starsLabel.text = "\(result.stats?.favourites ?? 0)"
        commentLabel.text = "\(result.stats?.comments ?? 0)"
    }

    private func setImageViewWhenFailure() {
        srcImageView.image = UIImage(named: "bigEmpty")
    }
}

extension DailyTableViewCell {
    func setupAccessibility(row: Int) {
        setAccessibilityIdentifier(.dailyTableViewCell, row: row)
    }
}
