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
        endBackspaceTimer()
        backspaceTimer = Timer.repeat(0.1, { [unowned self] in
            if self.currentMagnifierCell.isDelete {
                UIDevice.current.playInputClick()
                self.didTapCell?(self.currentMagnifierCell)
            }
        })
        RunLoop.main.add(backspaceTimer, forMode: RunLoopMode.commonModes)
    }
    

    func endBackspaceTimer() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(startBackspaceTimer), object: nil)
        if backspaceTimer != nil {
            backspaceTimer.invalidate()
            backspaceTimer = nil
        }
    }
    
    private func tappedCell(_ touches: Set<UITouch>) -> EmojiCell? {
        let touch = touches.first!
        let point = touch.location(in: self)
        let indexPath = indexPathForItem(at: point)
        if let idp = indexPath {
            let cell = cellForItem(at: idp) as! EmojiCell
            return cell
        }
        return nil
    }
    
    func hideMagnifierView() {
        magnifierImageView.isHidden = true
    }
    
    func showMagnifierForCell(_ cell: EmojiCell) {
        if cell.isDelete || cell.emotionImageView.image == nil {
            hideMagnifierView()
            return
        }
        let rect: CGRect = cell.convert(cell.bounds, to: self)
        magnifierImageView.center = CGPoint(x: rect.midX, y: magnifierImageView.center.y)
        magnifierImageView.bottom = rect.maxY - 6
        magnifierImageView.isHidden = false
        
        magnifierContentImageView.image = cell.emotionImageView.image
        magnifierContentImageView.y = 20
        magnifierContentImageView.layer.removeAllAnimations()
        
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
        touchMoved = false
        guard let cell = tappedCell(touches) else {
            return
        }
        currentMagnifierCell = cell
        showMagnifierForCell(currentMagnifierCell!)
        if !cell.isDelete && cell.emotionImageView.image != nil {
            UIDevice.current.playInputClick()
        }
        
        if cell.isDelete {
            endBackspaceTimer()
            perform(#selector(startBackspaceTimer), with: nil, afterDelay: 0.5)
        }
    }
    

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchMoved = true
        if currentMagnifierCell != nil && currentMagnifierCell!.isDelete {
            return
        }
        
        guard let cell = tappedCell(touches) else {
            return
        }
        if cell != currentMagnifierCell {
            if !currentMagnifierCell!.isDelete && !cell.isDelete {
                currentMagnifierCell = cell
            }
            showMagnifierForCell(cell)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let cell = tappedCell(touches) else {
            endBackspaceTimer()
            return
        }
        let checkCell = !currentMagnifierCell!.isDelete && cell.emotionImageView.image != nil
        let checkMove = !touchMoved && cell.isDelete
        if checkCell || checkMove {
            didTapCell?(currentMagnifierCell)
        }
        endBackspaceTimer()
        hideMagnifierView()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>?, with event: UIEvent?) {
        hideMagnifierView()
        endBackspaceTimer()
    }
}
