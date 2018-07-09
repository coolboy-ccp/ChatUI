//
//  AddMessageView.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit
import SnapKit

class AddMessageView: UIView {
    private let actionTitles: [String] = Defaults.actionTitles
    private let images: [UIImage] = Defaults.actionImages
    var isShow: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.2, animations: {
                self.alpha = self.isShow ? 1.0 : 0
            }) { (finished) in
                self.alpha = 1.0
                self.isHidden = !self.isShow
            }
        }
    }
    
    init(_ y: CGFloat) {
        super.init(frame: .zero)
        self.clipsToBounds = true
        initContents()
    }
    
    override func didMoveToSuperview() {
        self.snp.makeConstraints {
            $0.top.equalTo(y)
            $0.trailing.equalTo(0)
            $0.width.equalTo(Defaults.width)
            $0.height.equalTo(Defaults.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initContents() {
        let bgImgV = UIImageView(image: Defaults.bgImg)
        bgImgV.layer.cornerRadius = 5.0
        bgImgV.clipsToBounds = true
        self.addSubview(bgImgV)
        defer { self.sendSubview(toBack: bgImgV) }
        bgImgV.frame = self.bounds
        buttons()
        self.isHidden = true
        
    }
    
    private func buttons() {
        for (idx, obj) in actionTitles.enumerated() {
            let item = UIButton(type: .custom)
            item.backgroundColor = .clear
            item.setTitleColor(.white, for: UIControlState())
            item.setTitle(obj, for: UIControlState())
            item.add({ [unowned self] in
                let actType = ActionType(rawValue: idx) ?? .addGroup
                self.actionBlock(actType)
            })
            item.contentHorizontalAlignment = .left
            item.contentEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0)
            item.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0)
            self.addSubview(item)
            item.frame = CGRect(x: 0, y: Defaults.firstBtnY + Defaults.btnHeight * CGFloat(idx), width: frame.width, height: Defaults.btnHeight)
        }
    }
}

extension AddMessageView {
    private var actionBlock: (ActionType) -> Void {
        return {
            switch $0 {
            case .addFriend:
                print("addFriend")
            case .addGroup:
                print("addGroup")
                
            }
        }
    }
}

extension AddMessageView {
    enum ActionType: Int {
        case addGroup
        case addFriend
    }
    
    struct Defaults {
        static let width: CGFloat = 140
        static let btnHeight: CGFloat = 44
        static let firstBtnY: CGFloat = 12
        
        static let actionTitles: [String] = [
            "发起群聊",
            "添加朋友"
        ]
        
        static let actionImages: [UIImage] = [
            ChatImg.Contacts_add_newmessage,
            ChatImg.Barbuttonicon_add_cube
            ].map { $0.image }
        
        static let bgImg = ChatImg.MessageRightTopBg.image
        
        static var height: CGFloat {
            let count = actionTitles.count
            return btnHeight * CGFloat(count) + firstBtnY
        }
    }
}
