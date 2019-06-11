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
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        //        let bgColorView = UIView()
        //        bgColorView.backgroundColor = .brandLightBlue
        //        selectedBackgroundView = bgColorView
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        UIView.animate(withDuration: 2.0) { [weak self] in
            if selected {
                self?.leadingConstraint.constant = -100
            } else {
                self?.leadingConstraint.constant = 120
            }
        }
    }
    
    func populate() {
        
    }
    
}
