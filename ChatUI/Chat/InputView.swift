//
//  InputView.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/6.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class InputView: UIView {

    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var voiceButton: ChatButton!
    @IBOutlet weak var emotionButton: ChatButton!
    @IBOutlet weak var shareButton: ChatButton!
    @IBOutlet weak var recordButton: UIButton!
    
    var recodingKeyboardBlock: ActionBlock?
    var showEmojiKeyboardBlock: ActionBlock?
    var showMoreKeyboardBlock: ActionBlock?
    
    private(set) var keyboardType: KeyboardType = .default
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textviewStyle()
        recordBtnStyle()
    }
    
    private func textviewStyle() {
        inputTextView.layer.borderColor = CGColor.hex("#DADADA")
        inputTextView.layer.borderWidth = 1
        inputTextView.layer.cornerRadius = 5.0
        inputTextView.textContainerInset = UIEdgeInsetsMake(7, 5, 5, 5)
        inputTextView.layoutManager.allowsNonContiguousLayout = false
        inputTextView.scrollsToTop = false
    }
    
    private func recordBtnStyle() {
        recordButton.setBackground(UIColor.hex("#F3F4F8"))
        recordButton.setTitleColor(UIColor.hex("#C6C7CB"), for: .highlighted)
    }
    
    func resetImgs() {
        voiceButton.setImage(ChatImg.Tool_voice_1.image, for: UIControlState())
        voiceButton.setImage(ChatImg.Tool_voice_2.image, for: .highlighted)
        emotionButton.setImage(ChatImg.Tool_emotion_1.image, for: UIControlState())
        emotionButton.setImage(ChatImg.Tool_emotion_2.image, for: .highlighted)
        shareButton.setImage(ChatImg.Tool_share_1.image, for: UIControlState())
        shareButton.setImage(ChatImg.Tool_share_2.image, for: .highlighted)
    }
    
    func textCallKeyboard() {
        keyboardType = .text
        inputTextView.isHidden = false
        recordButton.isHidden = true
        voiceButton.isShowKeyboard = false
        emotionButton.isShowKeyboard = false
        shareButton.isShowKeyboard = false
    }
    
    func showTextKeyboard() {
        inputTextView.becomeFirstResponder()
        textCallKeyboard()
    }
    
    func recording() {
        keyboardType = .default
        inputTextView.resignFirstResponder()
        inputTextView.isHidden = true
        recodingKeyboardBlock?()
        recordButton.isHidden = false
        voiceButton.isShowKeyboard = true
        emotionButton.isShowKeyboard = false
        shareButton.isShowKeyboard = false
    }
    
    func showEmojiKeyboard() {
        keyboardType = .emoji
        inputTextView.resignFirstResponder()
        inputTextView.isHidden = false
        showEmojiKeyboardBlock?()
        recordButton.isHidden = true
        emotionButton.isShowKeyboard = true
        shareButton.isShowKeyboard = false
    }
    
    func showMoreKeyboard() {
        keyboardType = .more
        inputTextView.resignFirstResponder()
        inputTextView.isHidden = false
        showMoreKeyboardBlock?()
        //设置接下来按钮的动作
        recordButton.isHidden = true
        emotionButton.isShowKeyboard = false
        shareButton.isShowKeyboard = true
    }
    
    func resignKeyboard() {
        keyboardType = .default
        inputTextView.resignFirstResponder()
        emotionButton.isShowKeyboard = false
        shareButton.isShowKeyboard = false
    }
    

}

extension InputView {
    enum KeyboardType: Int {
        case `default`
        case text
        case emoji
        case more
    }
    
    struct Defaults {
        static let originHeight: CGFloat = 50
        static let maxTextviewHeight: CGFloat = 120
    }
}
