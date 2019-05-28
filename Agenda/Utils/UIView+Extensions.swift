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
}
