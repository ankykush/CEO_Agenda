//
//  ContactsViewController.swift
//  Agenda
//
//  Created by Ankush jain on 29/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    var tcsMobNumArray = ["+1 (210) 241-8943", "+1 (210) 707-1951", "+(91) 9581388881"]
    var calltcsMobNumArray = ["12102418943", "12107071951", "919581388881"]
    var tcsNamesArray = ["Abhay Raje", "Shital Samant", "Lakshman Akella"]
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Helper Methods
    private func configureUI() {
        hideNavigationBar()
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @IBAction func homeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
 
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: UITableViewDataSource Methods
extension ContactsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tcsNamesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = tcsNamesArray[indexPath.row]
        cell.phoneNumberLbl.text = tcsMobNumArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let telNo = "telprompt:\(calltcsMobNumArray[indexPath.row])"
        if let url = URL(string: telNo) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
