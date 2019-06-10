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
//        let reminder = EKReminder(eventStore: appDelegate.eventStore)
//        
//        reminder.title = descriptionDetails.text!
//        reminder.calendar =
//            appDelegate.eventStore.defaultCalendarForNewReminders()
//        // Specify date components
//        let formatter = DateFormatter()
//        formatter.dateFormat = "dd MMMM yyyy HH:mm a"
//        formatter.date(from: <#T##String#>)
//        let someDateTime = formatter.date(from: "2016/10/08 22:31")
//        
//        
//        var dateComponents = DateComponents()
//        dateComponents.year = 1980
//        dateComponents.month = 7
//        dateComponents.day = 11
//        dateComponents.timeZone = TimeZone(abbreviation: "IST") // Japan Standard Time
//        dateComponents.hour = 8
//        dateComponents.minute = 34
//        
//        // Create date from components
//        let userCalendar = Calendar.current // user calendar
//        guard let date = userCalendar.date(from: dateComponents) else { return Date() }
//        
//        let alarm = EKAlarm(absoluteDate: date)
//        
//        reminder.addAlarm(alarm)
//        
//        do {
//            try appDelegate.eventStore?.save(reminder,
//                                             commit: true)
//        } catch let error {
//            print("Reminder failed with error \(error.localizedDescription)")
//        }
    }
    
    @IBAction func closeDetailsClicked(_ sender: Any) {
        hideDetailsClosure?()
    }
    
}
