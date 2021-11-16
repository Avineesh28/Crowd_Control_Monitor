//
//  ScheduleViewController.swift
//  Crowd Monitor
//
//  Created by Swamita on 19/03/21.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var fromDatePicker: UIDatePicker!
    @IBOutlet weak var toDatePicker: UIDatePicker!
    
    let dateFormatter = DateFormatter()
    let fromDateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageLabel.alpha = 0
        dateFormatter.dateFormat = "HH:mm"
        datePicker.datePickerMode = .time
        
        fromDateFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        fromDatePicker.datePickerMode = .dateAndTime
        
        toDatePicker.datePickerMode = .dateAndTime

    }
    
    @IBAction func dateSelected(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func fromDateTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func toDateTapped(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func timerPressed(_ sender: Any) {
        messageLabel.alpha = 1
        messageLabel.text = "🔔 Timer set successfully!"
        UIView.animate(withDuration: 2) {
            self.messageLabel.alpha = 0
        }
    }
    
    @IBAction func schedulePressed(_ sender: Any) {
        messageLabel.alpha = 1
        messageLabel.text = "🗓 Scheduled successfully!"
        UIView.animate(withDuration: 2) {
            self.messageLabel.alpha = 0
        }
    }
    
}
