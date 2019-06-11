//
//  ExecutiveViewController.swift
//  Agenda
//
//  Created by Ankush jain on 23/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit

class ExecutiveViewController: UIViewController {
    @IBOutlet weak var logoCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var completeDataArray: Executive?
    private var personDetailsArray: [ExecutiveElement]?
    static let collectionViewCellIdentifier = "executivecell"
    var executives: [ExecutiveElement] = [ExecutiveElement]()
    
    //MARK: Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getDataFromServer()
    }
    
    private func configureUI() {
        hideNavigationBar()
        tableView.tableFooterView = UIView()
    }
    
    func getDataFromServer() {
        
        let spinner = UIActivityIndicatorView(style: .gray)
        let viewBounds: CGRect = view.bounds
        spinner.center = CGPoint(x: viewBounds.midX, y: viewBounds.midY)
        view.addSubview(spinner) // spinner is not visible until started
        
        spinner.startAnimating()
        
        
        let url = URL.init(string: "https://jsonblob.com/api/jsonBlob/c4df7eb8-8506-11e9-b6c8-9f137ef9450a")
        
        let task = URLSession.shared.personTask(with: url!) { peopleArray, response, error in
            if peopleArray != nil {
                DispatchQueue.main.async {
                    self.completeDataArray = peopleArray
                    spinner.stopAnimating()
                    self.personDetailsArray = self.completeDataArray?.executives
                    self.logoCollectionView.reloadData()
                    self.tableView.reloadData()
                    let firstIndexPath = IndexPath(item: 0, section: 0)
                    self.logoCollectionView.selectItem(at: firstIndexPath, animated: true, scrollPosition: .left)
                    self.logoCollectionView.delegate?.collectionView?(self.logoCollectionView, didSelectItemAt: firstIndexPath)
                }
            } else {
                spinner.stopAnimating()
                //show error alert
            }
        }
        task.resume()
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
        cell.selectionStyle = .none
        if executives.count > 0 {
            cell.populate(executive: (executives[indexPath.row]))
        }
        
        return cell
    }
}

extension ExecutiveViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let executiveDetailViewController = UIStoryboard(name: "Executive", bundle: nil).instantiateViewController(withIdentifier: "ExecutiveDetailViewController") as? ExecutiveDetailViewController else {
            return
        }
        
        executiveDetailViewController.executive = executives[indexPath.row]
        navigationController?.pushViewController(executiveDetailViewController, animated: true)
    }
}

extension ExecutiveViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.completeDataArray?.orgNames?.count) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ExecutiveViewController.collectionViewCellIdentifier, for: indexPath) as? ExecutiveCollectionViewCell
        cell?.updateUI()
        let imageName = self.completeDataArray!.orgNames?[indexPath.row]
        cell?.logoImageView.image = UIImage(named: imageName!)
        // return the cell
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedOrg = self.completeDataArray!.orgNames?[indexPath.row]
        executives = (self.completeDataArray?.executives?.filter({
            $0.organization == selectedOrg
        }))!
        tableView.reloadData()
        
    }
    
}
