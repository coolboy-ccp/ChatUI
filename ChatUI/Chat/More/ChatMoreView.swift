//
//  ChatMoreView.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/10.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

enum ChatMoreType: Int {
    case photo
    case camera
}

class ChatMoreView: UIView {
    typealias DataSource = (name: String, icon: UIImage)
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var listCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    private let itemData = Defaults.itemData
    private let groupData = Defaults.groupData
    
    var clickCallback:((ChatMoreType) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listCollectionView.scrollsToTop = false
        setCollectionView()
        pageControl.numberOfPages = groupData.count
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        listCollectionView.width = UIScreen.width
    }
    
    private func setCollectionView() {
        let layout = FullyHorizontalFLY()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = Defaults.sectionInset
        let itemSizeWidth = (UIScreen.width - Defaults.hPadding * 2 - layout.minimumLineSpacing * (Defaults.oneRowCount - 1)) / Defaults.oneRowCount
        let itemSizeHeight = (collectionViewHeightConstraint.constant - Defaults.vPadding * 2) / 2
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeHeight)
        
        listCollectionView.collectionViewLayout = layout
        listCollectionView.registerCellNib(ChatMoreCell.self)
        listCollectionView.showsHorizontalScrollIndicator = false
        listCollectionView.isPagingEnabled = true
    }

}

extension ChatMoreView {
    private struct Defaults {
        static let hPadding: CGFloat = 15
        static let vPadding: CGFloat = 10
        static let oneRowCount: CGFloat = 4
        static let oneGroupCount: Int = 8
        
        static let itemData: [DataSource] = [
            ("照片", ChatImg.Sharemore_pic.image),
            ("相机", ChatImg.Sharemore_video.image),
            ("小视频", ChatImg.Sharemore_sight.image),
            ("视频聊天", ChatImg.Sharemore_videovoip.image),
            ("红包", ChatImg.Sharemore_wallet.image),
            ("转账", ChatImg.SharemorePay.image),
            ("位置", ChatImg.Sharemore_location.image),
            ("收藏", ChatImg.Sharemore_myfav.image),
            ("个人名片", ChatImg.Sharemore_friendcard.image),
            ("语音输入", ChatImg.Sharemore_voiceinput.image),
            ("卡券", ChatImg.Sharemore_wallet.image)
        ]
        
        static var groupData: [[DataSource]] {
            return itemData.chunk(oneGroupCount)
        }
        
        static let sectionInset = UIEdgeInsetsMake(vPadding, hPadding, vPadding, hPadding)
    }
}

extension ChatMoreView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let section = indexPath.section
        let row = indexPath.row
        let idx = section * Defaults.oneGroupCount + row
        if let type = ChatMoreType(rawValue: idx) {
            clickCallback?(type)
        }
    }
}



