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
    @IBOutlet weak var descriptionLbl: UITextView!
    
    @IBOutlet weak var descriptionView: UIView!
    var executive: ExecutiveElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        setupGestureRecognizer()
        populate(executive)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        descriptionLbl.setContentOffset(.zero, animated: false)
    }
    
    func populate(_ executive: ExecutiveElement?) {
        guard let executive = executive else { return }
        imageView.image = UIImage(named: executive.largeImg!)
        nameLbl.text = executive.name
        roleLbl.text = executive.designation
        descriptionLbl.text = executive.desc
        descriptionView.layer.cornerRadius = 10.0
        imageView.layer.cornerRadius = 5.0
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}


