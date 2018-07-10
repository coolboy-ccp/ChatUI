//
//  EmojiKeyboard.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/6.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

class EmojiKeyboard: UIView {

    @IBOutlet fileprivate weak var emotionPageControl: UIPageControl!
    @IBOutlet fileprivate weak var sendButton: UIButton!
    @IBOutlet fileprivate weak var listCollectionView: EmojiView!
    private var groupDataSouce = [[EmojiModel]]()
    private var emotionsDataSouce = [EmojiModel]()
    weak var delegate: EmojiInputDelegate?
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
        setLayout()
        setCallback()
        listTableSetting()
       
    }
    
    private func setCallback() {
        listCollectionView.didTapCell = { [unowned self] cell in
            if cell.isDelete {
                self.delegate?.didTapBackspace(cell)
            }
            else {
                self.delegate?.didTap(cell)
            }
        }
    }
    
    private func setLayout() {
        let itemWidth = (UIScreen.width - 10 * 2) / Defaults.oneRowCount
        let padding = (UIScreen.width - Defaults.oneRowCount * itemWidth) / 2.0
        let paddingLeft = padding
        let paddingRight = UIScreen.width - paddingLeft - itemWidth * Defaults.oneRowCount
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: itemWidth, height: Defaults.itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, paddingLeft, 0, paddingRight)
        self.listCollectionView.collectionViewLayout = layout
    }
    
    private func listTableSetting() {
        listCollectionView.registerCellNib(EmojiCell.self)
        self.listCollectionView.isPagingEnabled = true
        guard let emojiArray = Defaults.emojiArray else {
            fatalError("🌹🌹🌹 not found datasource")
        }
        for data in emojiArray {
            let model = EmojiModel.init(data)
            self.emotionsDataSouce.append(model)
        }
        self.groupDataSouce = emotionsDataSouce.chunk(Defaults.oneGroupCount)
        self.listCollectionView.reloadData()
        self.emotionPageControl.numberOfPages = self.groupDataSouce.count
    }
    
    @IBAction func send(_ sender: AnyObject) {
        delegate?.didTapSend()
    }
    
    private func model(for indexPath: IndexPath) -> EmojiModel? {
        let sec = indexPath.section
        var index = sec * Defaults.oneGroupCount + indexPath.row
        let idp = index / Defaults.oneGroupCount
        let ii = index % Defaults.oneGroupCount
        let reIndex = (ii % 3) * Int(Defaults.oneRowCount) + (ii / 3)
        index = reIndex + idp * Defaults.oneGroupCount
        if index < self.emotionsDataSouce.count {
            return self.emotionsDataSouce[index]
        }
        return nil
    }

}

extension EmojiKeyboard: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return groupDataSouce.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Defaults.oneGroupCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.resuableCell(EmojiCell.self, indexPath: indexPath)
        let md = (indexPath.row == Defaults.oneGroupCount) ? nil : model(for: indexPath)
        cell.setContents(md)
        return cell
    }
}

extension EmojiKeyboard: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

extension EmojiKeyboard: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth: CGFloat = self.listCollectionView.width
        self.emotionPageControl.currentPage = Int(self.listCollectionView.contentOffset.x / pageWidth)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.listCollectionView.hideMagnifierView()
        self.listCollectionView.endBackspaceTimer()
    }
}

extension EmojiKeyboard: UIInputViewAudioFeedback {
    internal var enableInputClicksWhenVisible: Bool {
        get { return true }
    }
}

extension EmojiKeyboard {
    struct  Defaults {
        static let itemH: CGFloat = 50
        static let oneGroupCount = 23
        static let oneRowCount: CGFloat = 8
        
        static var emojiArray: [[String : String]]? {
            guard let path = Bundle.main.path(forResource: "Expression", ofType: "plist") else {
                return nil
            }
            let array = NSArray(contentsOfFile: path) as? [[String : String]]
            return array
        }
    }
}



protocol EmojiInputDelegate: class {
    func didTap(_ cell: EmojiCell)
    func didTapBackspace(_ cell: EmojiCell)
    func didTapSend()
}
