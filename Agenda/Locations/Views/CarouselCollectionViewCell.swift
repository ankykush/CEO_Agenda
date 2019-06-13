//
//  CarouselContent.swift
//  Agenda
//
//  Created by Ankush jain on 28/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class CarouselCollectionViewCell: UICollectionViewCell {
    static let identifier = "CarouselCollectionViewCell"
    @IBOutlet weak var carouselImageView: UIImageView!
    @IBOutlet weak var carouselTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //carouselImageView.addShadow()
    }
    
    func configureUI(_ imageName: String) {
        carouselImageView.image = UIImage(named: imageName)
        carouselImageView.contentMode = .scaleToFill
        carouselTitle.text = imageName
    }
}
