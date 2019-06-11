//
//  NavController.swift
//  Agenda_CTDO
//
//  Created by Palash Roy on 1/31/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class NavController: UINavigationController {
    
    /// Custom back buttons disable the interactive pop animation
    /// To enable it back we set the recognizer to `self`
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension NavController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}
