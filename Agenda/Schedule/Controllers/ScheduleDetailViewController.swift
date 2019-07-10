//
//  ScheduleDetailViewController.swift
//  Agenda
//
//  Created by Ankush jain on 24/05/19.
//  Copyright © 2019 TCS. All rights reserved.
//

import UIKit
import EventKit
import QuartzCore

class ScheduleDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var nameView: UIStackView!
    @IBOutlet weak var cityLocationDetails: UILabel!
    @IBOutlet weak var eventLocationDetails: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var locationDetails: UILabel!
    @IBOutlet weak var presenterDetails: UILabel!
    @IBOutlet weak var timeDetails: UILabel!
    var arr = [String]()
    var reminder = EKReminder()
    var alarm = EKAlarm()
    let appDelegate = UIApplication.shared.delegate
        as! AppDelegate
    var hideDetailsClosure: (() -> Void)? = nil
    var scheduleData: Schedule?
    var selectedDate: ScheduleElement?
    var exec = ExecutiveViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        exec = (UIStoryboard(name: "Executive", bundle: nil).instantiateViewController(withIdentifier: "ExecutiveViewController") as? ExecutiveViewController)!
        exec.getDataFromServer()
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
        scrollView.contentOffset = CGPoint.zero

        scheduleData = selectedDateSchedule?.schedule[indexPath.row]
        selectedDate = selectedDateSchedule
        //checkReminderStatus()
        //cityLocationDetails.text = selectedDateSchedule?.place
        timeDetails.text = scheduleData?.time
        locationDetails.text = scheduleData?.place
        arr = scheduleData!.name
        collectionView.reloadData()
//        presenterDetails.text = scheduleData?.name
        descriptionDetails.text = scheduleData?.desc
//        eventLocationDetails.text = scheduleData?.place
    }
    
    func showExecutiveDetails(_ text: String ) {
        guard let executiveDetailViewController = UIStoryboard(name: "Executive", bundle: nil).instantiateViewController(withIdentifier: "ExecutiveDetailViewController") as? ExecutiveDetailViewController else {
            return
        }
        let arr = exec.completeDataArray?.executives!.filter{
            $0.name == text
        }
        if arr!.count == 0 {
            return
        }
        executiveDetailViewController.executive = arr![0]
        presentAsStork(executiveDetailViewController)
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
//        nameView.removeAllArrangedSubviews()
        scrollView.setContentOffset(.zero, animated: true)
        hideDetailsClosure?()
        
    }
    
}

extension ScheduleDetailViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.textLabel.text = self.arr[indexPath.row]
        if (scheduleData?.availableProfile.contains(self.arr[indexPath.row]))! {
            cell.backgroundColor = .white
        } else {
            cell.backgroundColor = .lightGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.arr[indexPath.row]
        let cellWidth = text.size(withAttributes:[.font: UIFont.systemFont(ofSize:15.0)]).width + 30.0
        return CGSize(width: cellWidth, height: 30.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let text = self.arr[indexPath.row]
        showExecutiveDetails(text)
    }
}




