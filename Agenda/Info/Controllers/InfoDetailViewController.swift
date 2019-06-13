//
//  InfoDetailViewController.swift
//  Agenda
//
//  Created by Ankush jain on 09/06/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import WebKit
import PDFKit


class InfoDetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    var pdfName: String?
    @IBOutlet weak var headerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        
        titleLbl.text = pdfName!
        let pdfView = PDFView()
        //self.title = pdfName!
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        guard let path = Bundle.main.url(forResource: pdfName, withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
            pdfView.scaleFactor = 0.6
        }

        
    }
    
}
