//
//  EmojiView.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/6.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class EmojiView: UICollectionView {

    private var touchMoved: Bool = false
    private let magnifierImageView = UIImageView(image: ChatImg.Emoticon_keyboard_magnifier.image)
    private var magnifierContentImageView = UIImageView()
    private var backspaceTimer: Timer!
    private var currentMagnifierCell: EmojiCell!
    
    private func initialize() {
        magnifierContentImageView.size = CGSize(40, 40)
        magnifierContentImageView.cX = magnifierImageView.width / 2
        magnifierImageView.addSubview(magnifierContentImageView)
        magnifierImageView.isHidden = true
        addSubview(magnifierImageView)
        
    }

    override func awakeFromNib() {
        initialize()
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        canCancelContentTouches = false
        scrollsToTop = false
    }
    
    @objc private func startBackspaceTimer() {
        self.endBackspaceTimer()
        self.backspaceTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [unowned self](timer) in
            
        })
//        CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + 1, 1, 0, 0, { [weak, self] (_) in
//            if self.currentMagnifierCell!.isDelete {
//                UIDevice.current.playInputClick()
//                self.emotionScrollDelegate?.emoticonScrollViewDidTapCell(self!.currentMagnifierCell!)
//            }
//        })
//        Timer.ts_every(0.1, {[weak self] in
//            if self!.currentMagnifierCell!.isDelete {
//                UIDevice.current.playInputClick()
//                self!.emotionScrollDelegate?.emoticonScrollViewDidTapCell(self!.currentMagnifierCell!)
//            }
//        })
        RunLoop.main.add(self.backspaceTimer, forMode: RunLoopMode.commonModes)
    }
    

    private func endBackspaceTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(startBackspaceTimer), object: nil)
        if self.backspaceTimer != nil {
            self.backspaceTimer.invalidate()
            self.backspaceTimer = nil
        }
    }

}
