//
//  ChatMoreCell.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/10.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class ChatMoreCell: UICollectionViewCell {
    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemLabel: UILabel!
   
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.itemButton.setBackgroundImage(ChatImg.Sharemore_other_HL.image, for: .highlighted)
            } else {
                self.itemButton.setBackgroundImage(ChatImg.Sharemore_other.image, for: UIControlState())
            }
        }
    }

}
