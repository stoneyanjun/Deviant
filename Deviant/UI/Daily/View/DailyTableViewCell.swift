//
//  DailyTableViewCell.swift
//  Deviant
//
//  Created by Stone on 29/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Kingfisher
import Reusable
import UIKit

class DailyTableViewCell: UITableViewCell, Reusable {
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet private var imageAspectNSLayoutConstraint: NSLayoutConstraint!
    @IBOutlet private var usericonImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var loadingImageView: UIImageView!
    @IBOutlet private var srcImageView: UIImageView!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var commentLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with result: DeviantDetailBase) {
        if let usericon = result.author?.usericon,
            let url = URL(string: usericon) {
            usericonImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"))
        } else {
            usericonImageView.image = UIImage(named: "AvatorWhite")
        }

        usernameLabel.text = result.author?.username
        titleLabel.text = result.title
        let resultTxt = String.getDateFormatString(timeStamp: result.publishedTime ?? "")
        timeLabel.text = resultTxt

        initImageView()

        if let width = result.preview?.width,
            let height = result.preview?.height {
            imageAspectNSLayoutConstraint.constant = CGFloat(width / height)
        }

        if let src = result.preview?.src ,
            let url = URL(string: src) {
            srcImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"), options: nil, progressBlock: nil) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success:
                    strongSelf.setImageViewWhenSuccess()
                case .failure:
                    strongSelf.setImageViewWhenFailure()
                }
            }
        } else {
            setImageViewWhenFailure()
        }
        starsLabel.text = "\(result.stats?.favourites ?? 0)"
        commentLabel.text = "\(result.stats?.comments ?? 0)"
    }

    private func initImageView() {
        srcImageView.image = nil
        loadingImageView.image = UIImage(named: "loading")
        loadingImageView.isHidden = false
    }

    private func setImageViewWhenFailure() {
        loadingImageView.image = UIImage(named: "bigEmpty")
        loadingImageView.isHidden = false
    }

    private func setImageViewWhenSuccess() {
        loadingImageView.isHidden = true
    }
}
