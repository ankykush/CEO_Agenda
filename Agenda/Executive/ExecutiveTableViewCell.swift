//
//  ExecutiveTableViewCell.swift
//  Agenda
//
//  Created by Sravanthi Kuppireddy on 5/27/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveTableViewCell: UITableViewCell {
    
    @IBOutlet weak var executiveImage: UIImageView!
    @IBOutlet weak var executiveName: UILabel!
    @IBOutlet weak var executiveRole: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0))
    }
    
    func populate(executive: Executive) {
        executiveName?.text = executive.name
        executiveRole?.text = executive.role
        executiveImage?.image = UIImage(named: executive.imageUrl)
    }
    
}
