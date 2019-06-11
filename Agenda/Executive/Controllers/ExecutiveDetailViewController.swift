//
//  ExecutiveDetailViewController.swift
//  Agenda
//
//  Created by Ankush jain on 24/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveDetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var roleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    var gestureRecognizer: UITapGestureRecognizer!
    
    var executive: ExecutiveElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupGestureRecognizer()
        populate(executive)
    }
    
    func setupGestureRecognizer() {
        gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        gestureRecognizer.numberOfTapsRequired = 2
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 2.0
        scrollView.addGestureRecognizer(gestureRecognizer)
    }
    
    func populate(_ executive: ExecutiveElement?) {
        guard let executive = executive else { return }
        //imageView.image =
        nameLbl.text = executive.name
        roleLbl.text = executive.designation
        descriptionLbl.text = executive.desc
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleDoubleTap() {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(CGFloat(scrollView.maximumZoomScale), center: gestureRecognizer.location(in: gestureRecognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
    
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = scrollContentView.frame.size.height / scale
        zoomRect.size.width = scrollContentView.frame.size.width / scale
        let newCenter = scrollView.convert(center, from: scrollContentView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
    
}

extension ExecutiveDetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return scrollContentView
    }
}
