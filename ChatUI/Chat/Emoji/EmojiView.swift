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
    
    var didTapCell: ((_ cell: EmojiCell) -> Void)?

    override func awakeFromNib() {
        initialize()
        clipsToBounds = false
        showsHorizontalScrollIndicator = false
        canCancelContentTouches = false
        scrollsToTop = false
    }
    
    @objc private func startBackspaceTimer() {
        self.endBackspaceTimer()
        self.backspaceTimer = Timer.repeat(0.1, { [unowned self] in
            if self.currentMagnifierCell.isDelete {
                UIDevice.current.playInputClick()
                self.didTapCell?(self.currentMagnifierCell)
            }
        })
        RunLoop.main.add(self.backspaceTimer, forMode: RunLoopMode.commonModes)
    }
    

    private func endBackspaceTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(startBackspaceTimer), object: nil)
        if self.backspaceTimer != nil {
            self.backspaceTimer.invalidate()
            self.backspaceTimer = nil
        }
    }
    
    private func tappedCell(_ touches: Set<UITouch>) -> EmojiCell? {
        let touch = touches.first!
        let point = touch.location(in: self)
        let indexPath = self.indexPathForItem(at: point)
        if let idp = indexPath {
            let cell = self.cellForItem(at: idp) as! EmojiCell
            return cell
        }
        return nil
    }
    
    private func hideMagnifierView() {
        self.magnifierImageView.isHidden = true
    }
    
    func showMagnifierForCell(_ cell: EmojiCell) {
        if cell.isDelete || cell.emotionImageView.image == nil {
            self.hideMagnifierView()
            return
        }
        let rect: CGRect = cell.convert(cell.bounds, to: self)
        self.magnifierImageView.center = CGPoint(x: rect.midX, y: self.magnifierImageView.center.y)
        self.magnifierImageView.bottom = rect.maxY - 6
        self.magnifierImageView.isHidden = false
        
        self.magnifierContentImageView.image = cell.emotionImageView.image
        self.magnifierContentImageView.y = 20
        self.magnifierContentImageView.layer.removeAllAnimations()
        
        let duration: TimeInterval = 0.1
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
            self.magnifierContentImageView.y = 3
        }, completion: {finished in
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                self.magnifierContentImageView.y = 6
            }, completion: {finished in
                UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                    self.magnifierContentImageView.y = 5
                }, completion:nil)
            })
        })
    }
}

extension EmojiView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchMoved = false
        guard let cell = self.tappedCell(touches) else {
            return
        }
        self.currentMagnifierCell = cell
        self.showMagnifierForCell(self.currentMagnifierCell!)
        if !cell.isDelete && cell.emotionImageView.image != nil {
            UIDevice.current.playInputClick()
        }
        
        if cell.isDelete {
            self.endBackspaceTimer()
            self.perform(#selector(startBackspaceTimer), with: nil, afterDelay: 0.5)
        }
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.touchMoved = true
        if self.currentMagnifierCell != nil && self.currentMagnifierCell!.isDelete {
            return
        }
        
        guard let cell = self.tappedCell(touches) else {
            return
        }
        if cell != self.currentMagnifierCell {
            if !self.currentMagnifierCell!.isDelete && !cell.isDelete {
                self.currentMagnifierCell = cell
            }
            self.showMagnifierForCell(cell)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let cell = tappedCell(touches) else {
            self.endBackspaceTimer()
            return
        }
        let checkCell = !self.currentMagnifierCell!.isDelete && cell.emotionImageView.image != nil
        let checkMove = !self.touchMoved && cell.isDelete
        if checkCell || checkMove {
            didTapCell?(currentMagnifierCell)
        }
        self.endBackspaceTimer()
        self.hideMagnifierView()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        self.hideMagnifierView()
        self.endBackspaceTimer()
    }
}
