//
//  LocationsViewController.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout

class LocationsViewController: UIViewController {
    //MARK: Properties
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationImages = ["Chennai", "Pune", "Hyderabad"]
    let aboutUsImages = ["TATA", "TCS"]
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont.systemFont(ofSize: 22)
        segment.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        configureUI()
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    private func configureUI() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        collectionView.reloadData()
    }
}


//MARK: iCarouselDataSource Methods
extension LocationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if segment.selectedSegmentIndex == 0 {
            return locationImages.count
        } else {
            return aboutUsImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCollectionViewCell.identifier, for: indexPath) as? CarouselCollectionViewCell else {
            return UICollectionViewCell()
        }
        if segment.selectedSegmentIndex == 0 {
            cell.configureUI(locationImages[indexPath.row])
        } else {
            cell.configureUI(aboutUsImages[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationDetailsVC = storyboard!.instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController
        if let locationDetailsVC = locationDetailsVC {
            if segment.selectedSegmentIndex == 0 {
                locationDetailsVC.pdfname = locationImages[indexPath.row]
            } else {
                locationDetailsVC.pdfname = aboutUsImages[indexPath.row]
            }
            locationDetailsVC.selectedIndex = segment.selectedSegmentIndex
            navigationController?.pushViewController(locationDetailsVC, animated: true)
        }
    }
    
    
    // MARK: - UIScrollViewDelegate
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout = self.collectionView.collectionViewLayout as! UPCarouselFlowLayout
//        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//    }

}


