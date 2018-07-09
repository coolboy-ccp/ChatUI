//
//  CCPColor.swift
//  CCPLauchView
//
//  Created by 储诚鹏 on 17/2/16.
//  Copyright © 2017年 chengpeng.chu. All rights reserved.
//

import UIKit


public extension UIColor {
    //rgba
    public class func rgb(_ colors : [CGFloat]) -> UIColor {
        var color : UIColor = .white
        let subColors = colors.map {$0 / 255.0}
        switch colors.count {
        case 1:
            color = UIColor(red: subColors[0], green: subColors[0], blue: subColors[0], alpha: 1.0)
            break
        case 2:
            color = UIColor(red: subColors[0], green: subColors[0], blue: subColors[0], alpha: subColors[1] * 255)
            break
        case 3:
            color = UIColor(red: subColors[0], green: subColors[1], blue: subColors[2], alpha: 1.0)
            break
        case 4:
            color = UIColor(red: subColors[0], green: subColors[1], blue: subColors[2], alpha: subColors[3] * 255)
            break
        default:
            fatalError("[CCPColor] the format of colors is illegal!")
            break
        }
        return color
    }
    
    public func to(alpha: CGFloat = 1.0) -> UIColor {
        if  alpha / 1.0 == 0{
            return self.withAlphaComponent(alpha)
        }
        else {
            return self
        }
    }

    //hex
    public class func hex(_ string : String) -> UIColor {
        var hex = string.hasPrefix("#") ? String(string.dropFirst()) : string
        guard hex.count == 3 || hex.count == 6 else {
            return UIColor.white
        }
        if hex.count == 3 {
            for (index,char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
       return  self.rgb([CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF),CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF),CGFloat((Int(hex, radix: 16)!) & 0xFF)])
        
    }
}

extension CGColor {
    public class func rgb(_ colors: [CGFloat]) -> CGColor {
        return UIColor.rgb(colors).cgColor
    }
    
    public class func hex(_ string: String) -> CGColor {
        return UIColor.hex(string).cgColor
    }
}

//gradient
//这个方法参考HUE
public extension Array where Element : UIColor {
   
    //inout 改变外部变量
    @discardableResult
    public func gradient(_ transform : ((_ g : inout CAGradientLayer) -> CAGradientLayer)? = nil) -> CAGradientLayer {
        var gradient = CAGradientLayer()
        gradient.colors = self.map {$0.cgColor}
        if let transform = transform {
            gradient = transform(&gradient)
        }
        return gradient
    }
}

extension UIColor {
    
    var components: [CGFloat] {
        let cg = self.cgColor
        let num = cg.numberOfComponents
        if num == 4 {
            if let cs = cg.components {
                return cs
            }
        }
        return [0,0,0,0]
    }
    
    var r: CGFloat {
        return components[0]
    }
    
    var g: CGFloat {
        return components[1]
    }
    
    var b: CGFloat {
        return components[2]
    }
    
    var a: CGFloat {
        return components[3]
    }
}

extension UIColor {
    func toImage(_ size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)
        guard let ctx = UIGraphicsGetCurrentContext() else {
            return nil
        }
        ctx.setFillColor(self.cgColor)
        ctx.fill(rect)
        defer { UIGraphicsEndImageContext() }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}



