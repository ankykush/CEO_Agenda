//
//  TabBarController.swift
//  Agenda
//
//  Created by Ankush jain on 30/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addGradientLayer()
        populateBarItems()
        
        UITabBar.appearance().backgroundImage = UIImage(named: "tabbar")
    }
    

    
    private func populateBarItems() {
        guard let tabBarItems = self.tabBar.items else {
            return
        }
        
        for item in tabBarItems {
            item.image = item.image?.withRenderingMode(.alwaysOriginal)
            item.selectedImage = item.selectedImage?.withRenderingMode(.alwaysOriginal)
        }
    }
    
//    private func addGradientLayer() {
//        let layerGradient = CAGradientLayer()
//        layerGradient.colors = [UIColor(red: 66.0/255.0, green: 89.0/255.0, blue: 137.0/255.0, alpha: 1).cgColor,
//                                UIColor(red: 118.0/255.0, green: 161.0/255.0, blue: 175.0/255.0, alpha: 1).cgColor]
//        layerGradient.startPoint = CGPoint(x: 0.2, y: 0.5)
//        layerGradient.endPoint = CGPoint(x: 1.0, y: 0.5)
//        layerGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//        tabBar.layer.addSublayer(layerGradient)
//    }
}
