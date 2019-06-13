//
//  ExecutiveCollectionViewCell.swift
//  Agenda
//
//  Created by Palash Roy on 5/31/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var companyLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.alpha = 0.5
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected
            {
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.contentView.alpha = 1.0
            }
            else
            {
                self.transform = CGAffineTransform.identity
                self.contentView.alpha = 0.5
            }
        }
    }
    
    func updateUI() {
    }
    
}
