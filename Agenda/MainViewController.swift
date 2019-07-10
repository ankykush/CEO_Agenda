//
//  MainViewController.swift
//  Agenda
//
//  Created by Palash Roy on 6/13/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftArrowLeadConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightarrow: UIImageView!
    @IBOutlet weak var leftarrow: UIImageView!
    @IBOutlet weak var arrowtrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        leftarrow.isHidden = true
        scrollView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.leftArrowLeadConstraint.constant = 0
        self.arrowtrailConstraint.constant = 0
    }
    
    @IBAction func leftBtnClicked(_ sender: Any) {
        
        scrollToPage(page: 0, animated: true)
    }
    @IBAction func rightBtnClicked(_ sender: Any) {
        scrollToPage(page: 1, animated: true)
    }
    
    func scrollToPage(page: Int, animated: Bool) {
        var frame: CGRect = self.scrollView.frame
        frame.origin.x = frame.size.width * CGFloat(page)
        frame.origin.y = 0
        self.scrollView.scrollRectToVisible(frame, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollView.contentSize =  CGSize(width: self.view.frame.size.width * 2, height: self.view.frame.size.height)
        bounceLeftanimation()
        bounceRightAnimation()
    }
    
    func bounceLeftanimation() {
        let constant = self.leftArrowLeadConstraint.constant
        UIView.animate(withDuration: 0.6, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.leftArrowLeadConstraint.constant = constant + 30
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func bounceRightAnimation() {
        let constant = self.arrowtrailConstraint.constant
        UIView.animate(withDuration: 0.6, delay: 1.0, options: [.repeat, .autoreverse], animations: {
            self.arrowtrailConstraint.constant = constant - 30
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
}
extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var page: Int = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        if page == 1 {
            rightarrow.isHidden = true
            leftarrow.isHidden = false
            rightBtn.isHidden = true
            leftBtn.isHidden = false
        } else {
            leftarrow.isHidden = true
            rightarrow.isHidden = false
            
            leftBtn.isHidden = true
            rightBtn.isHidden = false
        }
    }
}
