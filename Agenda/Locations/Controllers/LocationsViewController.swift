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
        configureUI()
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
        
        guard let carouselContentView = CarouselContent.instantiateFromNib() else {
            return UIView()
        }
        
        //        carouselContentView.frame.size = CGSize(width: self.view.frame.size.width/2, height: 83.0)
        carouselContentView.backgroundColor = UIColor.lightGray
        carouselContentView.carouselImageView.image = UIImage(named: locationImages[index])
        carouselContentView.contentMode = .scaleAspectFill
        
        return carouselContentView
    }
}

//MARK: iCarouselDelegate Methods
extension LocationsViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, itemTransformForOffset offset: CGFloat, baseTransform transform: CATransform3D) -> CATransform3D {
        let trans = CATransform3DRotate(transform, CGFloat.pi / 8.0, 0.0, 1.0, 0.0)
        return CATransform3DTranslate(trans, 0.0, 0.0, offset * carousel.itemWidth)
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .wrap:
            return 0
        case .spacing:
            return value * 1.05
        default:
            return value
        }
    }
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        
    }
}
