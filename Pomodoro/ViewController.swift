//
//  ViewController.swift
//  Pomodoro
//
//  Created by Central States SER mac  on 5/12/20.
//  Copyright © 2020 Central States SER mac . All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pomCount: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var pomIn: UITextField!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    var poms = 0 //number of pomodoros to run
    var timer = Timer() //timer object
    var isTimerRunning = false //checks to see if timer is already running
    var resumeTapped = false //checks to see if timer is stopped or not
    var seconds = 0
    var isbreak = false
    
    func getPoms () {
        let text: String = pomIn.text!
        poms = Int(text)!
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if isTimerRunning == false{
            getPoms()
            pauseButton.isHidden = false
            resetButton.isHidden = false
            pomCount.isHidden = false
            startButton.isHidden = true
            pomIn.isHidden = true
            runPom()
        }
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        if self.resumeTapped == false {
            timer.invalidate()
            self.resumeTapped = true
            self.pauseButton.setTitle("RESUME", for: .normal)
        } else {
            runTimer()
            self.resumeTapped = false
            self.pauseButton.setTitle("PAUSE", for: .normal)
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer.invalidate()
        seconds = 0
        timerLabel.text = timeString(time: TimeInterval(seconds))
        isTimerRunning = false
        pauseButton.isHidden = true
        resetButton.isHidden = true
        pomCount.isHidden = true
        startButton.isHidden = false
        pomIn.isHidden = false
    }
    
    func runPom() {
        pomCount.text = "\(poms)"
        if isbreak {
            seconds = 5
        } else {
            seconds = 10
        }
      runTimer()
    }
    
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        isTimerRunning = true
    }
    
    @objc func updateTimer() {
        if poms > 0 {
            if seconds < 1 {
                timer.invalidate()
                //send notification
                if isbreak == true {
                    isbreak = false
                    notification(msg: "Break time is over!")
                    poms -= 1
                } else {
                    isbreak = true
                    notification(msg: "Time for a break!")
                }
                runPom()
            } else {
                seconds -= 1
                timerLabel.text = timeString(time:TimeInterval(seconds))
            }
        }
    }
    func notification(msg:String) {
        let content = UNMutableNotificationContent()
        content.title = "Timer is done!"
        content.body = msg
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.5, repeats: false)
        let request = UNNotificationRequest(identifier: "TestIdentifier", content: content, trigger: trigger)
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert,.sound,.badge])
    }
    
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes,seconds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            
            if error != nil {
                // Handle the error here.
                print("Error")
            }
        }
    }


}

