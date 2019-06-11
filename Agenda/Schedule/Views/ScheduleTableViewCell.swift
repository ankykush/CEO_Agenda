//
//  ScheduleTableViewCell.swift
//  Agenda
//
//  Created by Ankush jain on 29/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var venueLbl: UILabel!
    @IBOutlet weak var purposeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let bgColorView = UIView()
//        bgColorView.backgroundColor = .brandLightBlue
//        selectedBackgroundView = bgColorView
    }

    func populate() {
        
    }

}
