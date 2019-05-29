//
//  CarouselContent.swift
//  Agenda
//
//  Created by Ankush jain on 28/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class CarouselContent: UIView {
    @IBOutlet weak var carouselImageView: UIImageView!
    @IBOutlet weak var carouselTitle: UILabel!
    
    func configureUI(_ imageName: String) {
        backgroundColor = UIColor.lightGray
        carouselImageView.image = UIImage(named: imageName)
        carouselImageView.contentMode = .scaleToFill
    }
}
