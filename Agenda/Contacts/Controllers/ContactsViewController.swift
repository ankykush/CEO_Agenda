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
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK: Helper Methods
    private func configureUI() {
        hideNavigationBar()
        tableView.tableFooterView = UIView()
    }
    
}

//MARK: UITableViewDataSource Methods
extension ContactsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell else {
            return UITableViewCell()
        }
        //cell.populate()
        return cell
    }
}
