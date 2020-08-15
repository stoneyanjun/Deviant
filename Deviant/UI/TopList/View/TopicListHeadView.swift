//
//  TopicListHeadView.swift
//  Deviant
//
//  Copyright © 2020 Stone. All rights reserved.
//

import Reusable
import UIKit

class TopicListHeadView: UICollectionReusableView, Reusable {
    var tapHandle: (() -> Void)?
    @IBOutlet var topicLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func topicAction(_ sender: Any) {
        tapHandle?()
    }
}
