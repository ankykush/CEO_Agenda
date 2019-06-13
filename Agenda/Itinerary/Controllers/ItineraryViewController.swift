//
//  ItineraryViewController.swift
//  Agenda
//
//  Created by Ankush jain on 13/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import SPStorkController

struct ExecutiveItinerary {
    var imageName: String
    var executiveName: String
    var pdfName: String
    var bookingID: String
}

class ItineraryViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    var itineraries = [ExecutiveItinerary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeModels()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    func initializeModels() {
        let executive1 = ExecutiveItinerary(imageName: "Michael", executiveName: "Michael Brady", pdfName: "Itinerary Michael Brady", bookingID: "#NDRSEZ")
        let executive2 = ExecutiveItinerary(imageName: "Andrew", executiveName: "Andrew Walker", pdfName: "Itinerary Andrew Walker", bookingID: "#NBHMHR")
        let executive3 = ExecutiveItinerary(imageName: "Miller", executiveName: "Paul Miller", pdfName: "Itinerary Paul Miller", bookingID: "#NCDLNW")
        let executive4 = ExecutiveItinerary(imageName: "Miller", executiveName: "Paul Miller", pdfName: "Itinerary Paul Miller 2nd", bookingID: "#YKSOHF")
        
        itineraries = [executive1, executive2, executive3, executive4]
    }

    @IBAction func contactsAction(_ sender: Any) {
        if let contactsVC = UIStoryboard(name: "Contacts", bundle: nil).instantiateViewController(withIdentifier: "ContactsViewController") as? ContactsViewController {
            presentAsStork(contactsVC)

            //navigationController?.pushViewController(contactsVC, animated: true)
        }
    }

}


//MARK: UITableViewDataSource Methods
extension ItineraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itineraries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ItineraryTableViewCell", for: indexPath) as? ItineraryTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        let itinerary = itineraries[indexPath.row]
        cell.populate(itinerary)
        
        return cell
    }
}

extension ItineraryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showItinerary(indexPath)
    }
    
    func showItinerary(_ indexPath: IndexPath) {
        let infoDetailsVC = UIStoryboard(name: "Info", bundle: nil).instantiateViewController(withIdentifier: "InfoDetailViewController") as? InfoDetailViewController
        if let infoDetailsVC = infoDetailsVC {
            infoDetailsVC.pdfName = itineraries[indexPath.row].pdfName
            infoDetailsVC.bookingID = itineraries[indexPath.row].bookingID
            presentAsStork(infoDetailsVC)
            //navigationController?.pushViewController(infoDetailsVC, animated: true)
        }
    }
}
