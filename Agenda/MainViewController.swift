//
//  MainViewController.swift
//  Agenda
//
//  Created by Palash Roy on 6/13/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var arrowLeadConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize =  CGSize(width: self.view.frame.size.width * 2, height: self.view.frame.size.height)
    }
    
    func bounceLeftanimation() {
        let constant = self.arrowLeadConstraint.constant
        UIView.animate(withDuration: 0.6, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.arrowLeadConstraint.constant = constant - 30
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func bounceRightAnimation() {
        let constant = self.arrowLeadConstraint.constant
        UIView.animate(withDuration: 0.6, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.arrowLeadConstraint.constant = constant - 30
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
 
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if page == 1 {
           rightArrorw.ishidden = false
        }
    }
}
