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
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func configureUI() {
        //contentView.addBottomInset()
        containerView.addShadow()
    }
    
    func populate(executive: Executive) {
        executiveName?.text = executive.name
        executiveRole?.text = executive.role
        executiveImage?.image = UIImage(named: executive.imageUrl)
    }
}
