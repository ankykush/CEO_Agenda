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
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var cityLocationDetails: UILabel!
    @IBOutlet weak var eventLocationDetails: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var locationDetails: UILabel!
    @IBOutlet weak var presenterDetails: UILabel!
    @IBOutlet weak var timeDetails: UILabel!
    var reminder = EKReminder()
    var alarm = EKAlarm()
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    var hideDetailsClosure: (() -> Void)? = nil
    var scheduleData: Schedule?
    var selectedDate: ScheduleElement?
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    func createReminder() {
        alarmSwitch.isOn = false
        reminder = EKReminder(eventStore: appDelegate.eventStore)
        if scheduleData?.meeting != "" {
            reminder.title = scheduleData?.meeting
        } else {
            reminder.title = scheduleData?.desc
        }
        reminder.calendar =
            appDelegate.eventStore.defaultCalendarForNewReminders()
        // Specify date components
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy HH:mm a"
        if let selectedDate = selectedDate, let scheduleData = scheduleData, let date = formatter.date(from: (selectedDate.dates + " " + scheduleData.time)) {
            alarm = EKAlarm(absoluteDate: date)
            let dueDateComponents = appDelegate.dateComponentFromDate(date: date)
            reminder.dueDateComponents = dueDateComponents
            reminder.calendar = appDelegate.eventStore.defaultCalendarForNewReminders()
            reminder.dueDateComponents = dueDateComponents
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = self.view.frame.size
    }
    
    func checkReminderStatus() {
        
//        createReminder()
        
        let predicate = appDelegate.eventStore.predicateForReminders(in: nil)
        appDelegate.eventStore.fetchReminders(matching: predicate, completion: { (reminders: [EKReminder]?) -> Void in
            if let reminders = reminders {
                for remind in reminders {
                    if remind.title == self.reminder.title && remind.completionDate == self.reminder.completionDate {
                        self.reminder = remind
                        DispatchQueue.main.async {
                           self.alarmSwitch.isOn = true
                        }
                    }
                }
            }
        })
    }
    
    func populate(_ selectedDateSchedule: ScheduleElement?, indexPath: IndexPath) {
        
        scheduleData = selectedDateSchedule?.schedule[indexPath.row]
        selectedDate = selectedDateSchedule
        //checkReminderStatus()
        //cityLocationDetails.text = selectedDateSchedule?.place
        timeDetails.text = scheduleData?.time
        locationDetails.text = scheduleData?.place
        presenterDetails.text = scheduleData?.name
        descriptionDetails.text = scheduleData?.desc
//        eventLocationDetails.text = scheduleData?.place
    }
    
    
    
    @IBAction func addReminder(_ sender: Any) {
        let switchV = sender as! UISwitch
            do {
                if switchV.isOn {
                    try appDelegate.eventStore.save(reminder, commit: true)
                    reminder.addAlarm(alarm)
                    
                } else {
                    reminder.removeAlarm(alarm)
                    try appDelegate.eventStore.remove(reminder, commit: true)
                    createReminder()
                }
                
            } catch let error {
                print("Reminder failed with error \(error.localizedDescription)")
            }
        
    }
    
    @IBAction func closeDetailsClicked(_ sender: Any) {
        hideDetailsClosure?()
    }
    
}
