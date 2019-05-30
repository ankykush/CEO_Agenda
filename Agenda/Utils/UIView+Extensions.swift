//
//  UIView+Extensions.swift
//  Agenda
//
//  Created by Ankush jain on 27/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

extension UIView {
    func addShadow() {
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowRadius = 5
        layer.shadowOffset = .zero
        layer.shadowOpacity = 1
    }
    
    func addBottomInset() {
        frame = frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    public class func instantiateFromNib<T: UIView>(_ viewType: T.Type) -> T? {
        return Bundle.main.loadNibNamed(String(describing: viewType), owner: nil, options: nil)?.first as? T
        
    }
    
    public class func instantiateFromNib() -> Self? {
        return instantiateFromNib(self)
    }
    
}

extension UIImage {
    func imageWithColor(color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
