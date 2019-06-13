//
//  ItineraryTableViewCell.swift
//  Agenda
//
//  Created by Ankush jain on 13/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import UILabel_Copyable

class ItineraryTableViewCell: UITableViewCell {
    @IBOutlet weak var executiveImage: UIImageView!
    @IBOutlet weak var executiveName: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    private func configureUI() {

    }
    
    func populate(_ itinearary: ExecutiveItinerary) {
        executiveName?.text = itinearary.executiveName
        executiveImage?.image = UIImage(named: itinearary.imageName)
    }
}
