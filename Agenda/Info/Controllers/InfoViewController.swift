//
//  InfoViewController.swift
//  Agenda
//
//  Created by Ankush jain on 30/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    @IBAction func aboutTataAction(_ sender: Any) {
        let infoDetailsVC = storyboard!.instantiateViewController(withIdentifier: "InfoDetailViewController") as? InfoDetailViewController
        if let infoDetailsVC = infoDetailsVC {
            infoDetailsVC.pdfName = "TATA"
            navigationController?.pushViewController(infoDetailsVC, animated: true)
        }
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func aboutTCSAction(_ sender: Any) {
        let infoDetailsVC = storyboard!.instantiateViewController(withIdentifier: "InfoDetailViewController") as? InfoDetailViewController
        if let infoDetailsVC = infoDetailsVC {
            infoDetailsVC.pdfName = "TCS"
            navigationController?.pushViewController(infoDetailsVC, animated: true)
        }
    }
    
}
