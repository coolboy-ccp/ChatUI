//
//  Utils.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

typealias ActionBlock = () -> Void

final class ClosureWrapper {
    let cb: ActionBlock
    init(_ callback: @escaping ActionBlock) {
        self.cb = callback
    }
    
    @objc func invoke() {
        cb()
    }
}

extension UIButton {
    /*
     the default frame is just for navigationItem
     */
    static func customButton(_ image: UIImage, action: @escaping ActionBlock, frame: CGRect = CGRect(x: 0, y: 0, width: 40, height: 30)) -> UIButton {
        let button: UIButton = UIButton(type: .custom)
        button.setImage(image, for: UIControlState())
        button.frame = frame
        button.imageView!.contentMode = .scaleAspectFit
        button.add(action)
        return button
    }
    
    func add(_ action: @escaping ActionBlock, events: UIControlEvents = .touchUpInside) {
        let wrapper = ClosureWrapper(action)
        self.addTarget(wrapper, action: #selector(ClosureWrapper.invoke), for: events)
    }
}

extension UINavigationItem {
    private func toItems(contentAlignment: UIControlContentHorizontalAlignment = .left, image: UIImage, action: @escaping ActionBlock) -> [UIBarButtonItem] {
        let button = UIButton.customButton(image, action: action)
        button.contentHorizontalAlignment = contentAlignment
        let barItem = UIBarButtonItem(customView: button)
        let gapItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        gapItem.width = -7
        return [gapItem, barItem]
    }
    
    func left(_ image: UIImage, action: @escaping ActionBlock) {
        self.leftBarButtonItems = toItems(image: image, action: action)
    }
    
    func right(_ image: UIImage, action: @escaping ActionBlock) {
        self.rightBarButtonItems = toItems(image: image, action: action)
    }
}

extension UIViewController {
    func back(_ image: UIImage = ChatImg.Barbuttonicon_back.image) {
        self.navigationItem.left(image) { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    static func fromXib<T: UIViewController>(_ vcClass: T.Type) -> T {
        let name = String(describing: vcClass)
        let vc = T(nibName: name, bundle: nil)
        return vc
    }
    
}

extension UITableView: CellRegisterable{
    typealias T = UITableViewCell
    //cellClass name must equal to xib name
    func registerCellNib<T: UITableViewCell>(_ cellClass: T.Type) {
        self.registerCellNib(cellClass) { (nib, identifier) in
            self.register(nib, forCellReuseIdentifier: identifier)
        }
    }
    
    func reusableCell<T: UITableViewCell>(_ cellClass: T.Type) -> T {
        let name = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withIdentifier: name) as? T else {
            fatalError("🌹🌹🌹 [reusableCell]: \(name) isn't registed")
        }
        return cell
    }
}

extension UICollectionView: CellRegisterable {
    typealias T = UICollectionViewCell
    
    func registerCellNib<T: UICollectionViewCell>(_ cellClass: T.Type) {
        self.registerCellNib(cellClass) { (nib, identifier) in
            self.register(nib, forCellWithReuseIdentifier: identifier)
        }
    }
    
    func resuableCell<R: UICollectionViewCell>(_ cellClass: R.Type, indexPath: IndexPath) -> R {
        let name = String(describing: cellClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: name, for: indexPath)
            as? R else {
            fatalError("🌹🌹🌹 [reusableCell]: \(name) isn't registed")
        }
        return cell
    }
}

protocol CellRegisterable {
    associatedtype T
    func registerCellNib(_ cellClass: T.Type, block: (UINib, String) -> Void)
}

extension CellRegisterable {
    func registerCellNib(_ cellClass: T.Type, block: (UINib, String) -> Void) {
        let name = String(describing: cellClass)
        let nib = UINib(nibName: name, bundle: nil)
        block(nib, name)
    }
}

extension UIButton {
    func setBackground(_ color: UIColor, state: UIControlState = .normal) {
        let img = color.toImage(CGSize(width: 1, height: 1))
        self.setBackgroundImage(img, for: state)
    }
}

extension Timer {
    class func `repeat`(_ interval: TimeInterval, _ block: @escaping ActionBlock) -> Timer {
        return CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, CFAbsoluteTimeGetCurrent() + interval, interval, 0, 0, { (_) in
            block()
        })
    }
}

extension Array {
    /*
     * 数组分组,size是每个组元素个数
     */
    func chunk(_ size: Int = 1) -> [[Element]] {
        var result = [[Element]]()
        var chunk = -1
        for (index, elem) in self.enumerated() {
            if index % size == 0 {
                result.append([Element]())
                chunk += 1
            }
            result[chunk].append(elem)
        }
        return result
    }
}


