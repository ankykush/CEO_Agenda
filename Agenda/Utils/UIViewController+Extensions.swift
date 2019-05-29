//
//  UIViewController+Extensions.swift
//  Agenda
//
//  Created by Ankush jain on 28/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideNavigationBar(){
        // Hide the navigation bar on the this view controller
        navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    
    func showNavigationBar() {
        // Show the navigation bar on other view controllers
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
