//
//  ExecutiveViewController.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var executives = [
        Executive(name: "Name", role: "Role", imageUrl: "LINK-icon-directions"),
        Executive(name: "Name", role: "Role", imageUrl: "LINK-icon-directions"),
        Executive(name: "Name", role: "Role", imageUrl: "LINK-icon-directions")
    ]
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        hideNavigationBar()
        tableView.tableFooterView = UIView()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: UITableViewDataSource Methods
extension ExecutiveViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return executives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ExecutiveTableViewCell", for: indexPath) as? ExecutiveTableViewCell else {
            return UITableViewCell()
        }
        cell.populate(executive: executives[indexPath.row])
        return cell
    }
}
