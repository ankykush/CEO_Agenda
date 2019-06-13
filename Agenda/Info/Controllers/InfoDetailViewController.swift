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
import UILabel_Copyable


class InfoDetailViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    let pdfView = PDFView()
    
    var pdfName: String?
    
    var itinerary: ExecutiveItinerary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        
        titleLbl.text = "Itinerary for \(itinerary!.executiveName)"
        view.addSubview(pdfView)
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        loadPDF(itinerary!.internationalPdfName)
    }
    
    func loadPDF(_ name: String) {
        //self.title = pdfName!
       
        
        guard let path = Bundle.main.url(forResource: name, withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
            pdfView.scaleFactor = 0.6
        }

    }
    
    @IBAction func segmentAction(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            //international
            loadPDF(itinerary!.internationalPdfName)
        } else {
            //domestic
            loadPDF(itinerary!.domesticPdfName)
        }
    }
}
