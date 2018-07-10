//
//  EmojiCell.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/6.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class EmojiCell: UICollectionViewCell {

    @IBOutlet weak var emotionImageView: UIImageView!
    internal var isDelete: Bool = false
    
    private(set) var model: EmojiModel? = nil {
        didSet {
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        emotionImageView.image = nil
        model = nil
    }
    
    func setContents(_ md: EmojiModel? = nil) {
        guard let md = md else {
            emotionImageView.image = ChatImg.Emotion_delete.image
            isDelete = true
            model = nil
            return
        }
        model = md
        isDelete = false
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

struct EmojiModel {
    let imageName: String
    let text: String
    
    init(_ source: [String : String]) {
        self.imageName = source["image"]!
        self.text = source["text"]!
    }
}
