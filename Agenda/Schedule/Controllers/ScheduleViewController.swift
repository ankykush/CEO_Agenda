//
//  ScheduleViewController.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit


class ScheduleViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var scheduleDateScroller: UICollectionView!
    @IBOutlet weak var scheduleDetailsView: UIView!
    @IBOutlet weak var companyLbl: UILabel!
    
    private var scheduleDetailViewController: ScheduleDetailViewController?

    
    
    
    
    var finalScheduleArray: ScheduleData = ScheduleData()
    var selectedDateSchedule: ScheduleElement?
    var selectedIndexPath: IndexPath?
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        
        super.viewDidLoad()
        selectedIndexPath = [0,0]
        configureUI()
        getDataFromServer()
   
        scheduleDetailViewController?.hideDetailsClosure  = { [weak self] in
            

            self?.hideDetailsView()
        }
        
    
        
    }

    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Helper Methods
    private func configureUI() {
        hideNavigationBar()
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableView.automaticDimension
        
        scheduleDetailViewController = children.first as? ScheduleDetailViewController
        scheduleDateScroller.tag = 999
    }
    
    func dateCellClicked(at index: Int) {
        //let mainData : ScheduleElement = finalScheduleArray[index]
        
        //dateCellClicked(at: dateSelectedIndex)
        scheduleDateScroller.reloadData()
        
        ////
        
        
        //let cell: UICollectionViewCell? = scheduleDateScroller.cellForItem(at: IndexPath(row: index, section: 0))
        
        //if cell != nil {
        selectedDateSchedule = finalScheduleArray[index]
        //}
//        tableView.setContentOffset(CGPoint(x: 0, y: 0 - scheduleTableView.contentInset.top), animated: false)
        if let logo = selectedDateSchedule?.logo {
            companyLbl.text = logo
        }
        
        tableView.reloadData()
        let topIndex = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topIndex, at: .top, animated: true)
    }
    
    func showDetailsView() {
        scheduleDetailsView.fadeIn()
    }
    
    func hideDetailsView() {
        if !scheduleDetailsView.isHidden {
            scheduleDetailViewController?.scrollView.setContentOffset(.zero, animated: true)
            scheduleDetailsView.fadeOut()
        }
    }
    
    func getDataFromServer() {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        let viewBounds: CGRect = view.bounds
        spinner.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
        view.addSubview(spinner) // spinner is not visible until started
        
        spinner.startAnimating()
        
        
        let url = URL.init(string: "https://jsonblob.com/api/jsonBlob/87c7a2d8-9196-11e9-a889-fdf2fcc56ee2")
        
        let task = URLSession.shared.scheduleTask(with: url!) { scheduleArray, response, error in
            if  scheduleArray != nil {
                DispatchQueue.main.async {
                    
                    self.finalScheduleArray = scheduleArray!
                    //adding dummy elements to make sure selected element is always in the center
                    for i in 0...2 {
                        self.finalScheduleArray.insert(ScheduleElement(), at: i)
                        self.finalScheduleArray.append(ScheduleElement())
                    }
                    
                    spinner.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.scheduleDateScroller.isHidden = false
                    self.selectedIndexPath = IndexPath(row: 3, section: 0)
                    self.dateCellClicked(at: 3)
                    
                }
            }
        }
        task.resume()
    }
}

//MARK: UITableViewDataSource Methods
extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedDateSchedule?.schedule.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as? ScheduleTableViewCell
            else {
            return UITableViewCell()
        }
        //cell.populate()
        let scheduleData = selectedDateSchedule?.schedule[indexPath.row]
        cell.timeLbl.text = scheduleData?.time
        locationLabel.text = selectedDateSchedule?.place
        cell.venueLbl.text = scheduleData?.place
        cell.purposeLbl.text = scheduleData?.meeting 
        return cell
    }
}

extension ScheduleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        scheduleDetailViewController?.populate(selectedDateSchedule, indexPath: indexPath)
        showDetailsView()
    }
}

extension ScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //Collection view3 delegates & datasources
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return finalScheduleArray.count
    }
    
    static let collectionViewCellIdentifier = "datecell"
    static let collectionViewCellIdentifierSelected = "datecellselected"
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mainData = finalScheduleArray[indexPath.row] as? ScheduleElement
        if selectedIndexPath!.row == indexPath.row {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleViewController.collectionViewCellIdentifierSelected, for: indexPath) as? CollectionViewCellSelected
            if let day = mainData?.day, let date = mainData?.date, let month = mainData?.month
            {
                cell?.dateLabel.text = date
                cell?.dayLabel.text = day.uppercased()
                cell?.monthLabel.text = month.uppercased()
            }
            cell?.tag = indexPath.row
            // return the cell
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleViewController.collectionViewCellIdentifier, for: indexPath) as? CollectionViewCell
            if let day = mainData?.day, let date = mainData?.date
            {
                cell?.dateLabel.text = date
                cell?.dayLabel.text = String(day.prefix(1))
                
            }
            cell?.tag = indexPath.row
            // return the cell
            return cell!
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) // top, left, bottom, right
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let noOfItems = finalScheduleArray.count
        if [0, 1, 2, noOfItems - 1, noOfItems - 2, noOfItems - 3].contains(indexPath.row) {
            return
        }

        hideDetailsView()
        selectedIndexPath = indexPath
        dateCellClicked(at: indexPath.row)
   
    
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if selectedIndexPath?.row != indexPath.row {
            return CGSize(width: 50, height: 88)
        } else {
            return CGSize(width: 91, height: 98)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag == 999 {
            selectCenterItem()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.tag == 999 {
            selectCenterItem()
        }
    }
    
    func selectCenterItem() {
        let center = view.convert(scheduleDateScroller.center, to: self.scheduleDateScroller)
        guard let index = scheduleDateScroller.indexPathForItem(at: center) else { return }
        scheduleDateScroller.delegate?.collectionView?(scheduleDateScroller, didSelectItemAt: index)
    }
}
