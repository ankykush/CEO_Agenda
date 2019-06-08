//
//  ScheduleDetailViewController.swift
//  Agenda
//
//  Created by Ankush jain on 24/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import EventKit

class ScheduleDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var cityLocationDetails: UILabel!
    @IBOutlet weak var eventLocationDetails: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var locationDetails: UILabel!
    @IBOutlet weak var presenterDetails: UILabel!
    @IBOutlet weak var timeDetails: UILabel!
    
    var hideDetailsClosure: (() -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func populate(_ selectedDateSchedule: ScheduleElement?, indexPath: IndexPath) {
        let scheduleData = selectedDateSchedule?.schedule[indexPath.row]
        cityLocationDetails.text = selectedDateSchedule?.place
        timeDetails.text = scheduleData?.time
        locationDetails.text = scheduleData?.place
        presenterDetails.text = scheduleData?.name
        descriptionDetails.text = scheduleData?.desc
        eventLocationDetails.text = scheduleData?.place
    }
    
    @IBAction func addReminder(_ sender: Any) {
    }
    
    @IBAction func closeDetailsClicked(_ sender: Any) {
        hideDetailsClosure?()
    }
    
}
