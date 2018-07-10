//
//  Themes.swift
//  ChatUI
//
//  Created by 储诚鹏 on 2018/7/5.
//  Copyright © 2018年 储诚鹏. All rights reserved.
//

import UIKit

extension UIScreen {
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
}

extension UIView {
    var width: CGFloat {
        set {
            self.frame.size.width = newValue
        }
        get {
            return self.frame.width
        }
    }
    
    var height: CGFloat {
        return self.bounds.height
    }
    
    var x: CGFloat {
        return self.frame.minX
    }
    
    var y: CGFloat {
        set {
            self.frame.origin.y = newValue
        }
        get  {
            return self.frame.minY
        }
    }
    
    var size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            return self.frame.size
        }
    }
    
    var cY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center.y = newValue
        }
    }
    
    var cX: CGFloat {
        get {
            return self.center.x
            
        }
        set {
            self.center.x = newValue
        }
    }
    
    var bottom: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            self.y = newValue - self.height
        }
    }
}

extension CGSize {
    init(_ width: CGFloat, _ height: CGFloat) {
        self = CGSize(width: width, height: height)
    }
}

extension CGPoint {
    init(_ x: CGFloat, _ y: CGFloat) {
        self = CGPoint(x: x, y: y)
    }
}

extension CGRect {
    init(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) {
        self = CGRect(x: x, y: y, width: width, height: height)
    }
}

extension UIColor {
    class var barTintColor: UIColor {
        return UIColor.hex("#1A1A1A")
    }
    
    class var tabbarSelectedTextColor: UIColor {
        return UIColor.hex("#68BB1E")
    }
    
    class var viewBackgroundColor: UIColor {
        return UIColor.hex("#E7EBEE")
    }
}
