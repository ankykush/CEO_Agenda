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
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    var hideDetailsClosure: (() -> Void)? = nil
    var scheduleData: Schedule?
    var selectedDate: ScheduleElement?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func populate(_ selectedDateSchedule: ScheduleElement?, indexPath: IndexPath) {
        scheduleData = selectedDateSchedule?.schedule[indexPath.row]
        selectedDate = selectedDateSchedule
        cityLocationDetails.text = selectedDateSchedule?.place
        timeDetails.text = scheduleData?.time
        locationDetails.text = scheduleData?.place
        presenterDetails.text = scheduleData?.name
        descriptionDetails.text = scheduleData?.desc
        eventLocationDetails.text = scheduleData?.place
    }
    
    @IBAction func addReminder(_ sender: Any) {
        let switchV = sender as! UISwitch
        if switchV.isOn {
        let reminder = EKReminder(eventStore: appDelegate.eventStore)
        
        reminder.title = scheduleData?.meeting
        reminder.calendar =
            appDelegate.eventStore.defaultCalendarForNewReminders()
        // Specify date components
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm a"
        if let date = formatter.date(from: (selectedDate!.dates + " " + scheduleData!.time)) {
        
        
        
        // Create date from components
        
        let alarm = EKAlarm(absoluteDate: date)
        
        reminder.addAlarm(alarm)
        
        do {
            try appDelegate.eventStore.save(reminder,
                                             commit: true)
        } catch let error {
            print("Reminder failed with error \(error.localizedDescription)")
        }
        }
        } else {
            
        }
    }
    
    @IBAction func closeDetailsClicked(_ sender: Any) {
        hideDetailsClosure?()
    }
    
}
