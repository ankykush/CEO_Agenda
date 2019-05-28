//
//  LocationsViewController.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import iCarousel

class LocationsViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var carousel: iCarousel!
    
    let locationImages = ["location1", "location2", "location3"]
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureUI() {
        carousel.type = .coverFlow2
    }
}

//MARK: iCarouselDataSource Methods
extension LocationsViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return locationImages.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let imageView = UIImageView(frame:CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: locationImages[index])
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }
}

//MARK: iCarouselDelegate Methods
extension LocationsViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
    }
}
