//
//  ChatButton.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/6.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class ChatButton: UIButton {

    @IBInspectable var isShowKeyboard: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func emotionSwiftVoiceButtonUI(showKeyboard: Bool) {
        let img = showKeyboard ? ChatImg.Tool_keyboard_1.image : ChatImg.Tool_voice_1.image
        let imgHighlighted = showKeyboard ? ChatImg.Tool_keyboard_2.image : ChatImg.Tool_voice_2.image
        self.setImage(img, for: UIControlState())
        self.setImage(imgHighlighted, for: .highlighted)
    }
    func replaceEmotionButtonUI(showKeyboard: Bool) {
        if showKeyboard {
            self.setImage(ChatImg.Tool_keyboard_1.image, for: UIControlState())
            self.setImage(ChatImg.Tool_keyboard_2.image, for: .highlighted)
        } else {
            self.setImage(ChatImg.Tool_emotion_1.image, for: UIControlState())
            self.setImage(ChatImg.Tool_emotion_2.image, for: .highlighted)
        }
    }
    
    func replaceRecordButtonUI(isRecording: Bool) {
        if isRecording {
            self.setBackground(UIColor.hex("#C6C7CB"))
            self.setBackground(UIColor.hex("#F3F4F8"), state: .highlighted)
        } else {
            self.setBackground(UIColor.hex("#F3F4F8"))
            self.setBackground(UIColor.hex("#C6C7CB"), state: .highlighted)
        }
    }
}

