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

    @IBOutlet private var usericonImageView: UIImageView!
    @IBOutlet private var usernameLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var srcImageView: UIImageView!
    @IBOutlet private var starsLabel: UILabel!
    @IBOutlet private var commentLabel: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(with result: DailyResult) {
        if let usericon = result.author?.usericon,
            let url = URL(string: usericon) {
            usericonImageView.kf.setImage(with: url)
        } else {
            usericonImageView.image = UIImage(named: "AvatorWhite")
        }

        usernameLabel.text = result.author?.username
        titleLabel.text = result.title
        let resultTxt = String.getDateFormatString(timeStamp: result.publishedTime ?? "")

        if let src = result.preview?.src ,
            let url = URL(string: src) {
            print(src)
            srcImageView.kf.setImage(with: url, placeholder: UIImage(named: "loading"), options: nil, progressBlock: nil)
        } else {
            srcImageView.image = UIImage(named: "NotFound")
        }
        starsLabel.text = "\(result.stats?.favourites ?? 0)"
        commentLabel.text = "\(result.stats?.comments ?? 0)"
    }
}
