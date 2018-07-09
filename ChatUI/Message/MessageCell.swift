//
//  MessageCell.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit
import Kingfisher

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var unreadNumberLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width / 2 / 180 * 30
        self.unreadNumberLabel.layer.masksToBounds = true
        self.unreadNumberLabel.layer.cornerRadius = self.unreadNumberLabel.height / 2.0
    }
    
    func setContent(_ model : MessageModel) {
        self.avatarImageView.kf.setImage(with: URL(string: model.middleImageURL!))
        self.unreadNumberLabel.text = model.unreadNumber! > 99 ? "99+" : String(model.unreadNumber!)
        self.unreadNumberLabel.isHidden = (model.unreadNumber == 0)
        self.lastMessageLabel.text = model.latest!
        self.dateLabel.text = model.dateString!
        self.nameLabel.text = model.nickname!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
