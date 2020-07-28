//
//  TopicListHeadView.swift
//  Deviant
//
//  Created by Stone on 28/7/2020.
//  Copyright © 2020 JustNow. All rights reserved.
//

import Reusable
import UIKit

class TopicListHeadView: UICollectionReusableView, Reusable {
    var tapHandle: (() -> Void)?
    @IBOutlet var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @objc func tapAction() {
        tapHandle?()
    }
}
