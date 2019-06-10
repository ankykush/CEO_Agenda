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

    @IBOutlet weak var detailWebView: WKWebView!
    var pdfName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        let pdfView = PDFView()
        self.title = "ABOUT " + pdfName!
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        guard let path = Bundle.main.url(forResource: pdfName, withExtension: "pdf") else { return }
        
        if let document = PDFDocument(url: path) {
            pdfView.document = document
            pdfView.scaleFactor = 1.7
        }

        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
