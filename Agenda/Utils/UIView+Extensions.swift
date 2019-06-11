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
        layer.shadowRadius = 2
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


extension UIDevice {
    var hasNotch: Bool {
        let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
        return bottom > 0
    }
}


extension UIView {
    
    func fadeIn() {
        self.alpha = 0
        self.isHidden = false
        UIView.transition(with: self, duration: 0.5, options: .transitionCurlDown, animations: {
            self.alpha = 1
        }) { (value) in
            
        }
    }
    
    func fadeOut() {
        UIView.transition(with: self, duration: 0.5, options: .transitionCurlUp, animations: {
            self.alpha = 0
        }) { (value) in
            self.isHidden = true
        }
    }
    
}
