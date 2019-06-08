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
    
    var executive: ExecutiveElement?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populate(executive)
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
    
}
