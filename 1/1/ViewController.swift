//
//  ViewController.swift
//  batteryLevelNotification
//
//  Created by Alberto on 04/11/2018.
//  Copyright © 2018 Alberto. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    var batteryState: UIDevice.BatteryState{
        return UIDevice.current.batteryState
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIDevice.current.isBatteryMonitoringEnabled = true

        // Accepting Notification
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {(granted, error) in
            if granted {
                print("Notification granted!")
            }else{
                print(error?.localizedDescription as Any)
            }
        })
    }
    
    var batteryCharged: Float {
        return UIDevice.current.batteryLevel
    }
    
        // Switch
        
    @IBAction func `switch`(_ sender: UISwitch) {
    
        if sender.isOn {
            
            if batteryCharged == -1.0{
            notification(inSeconds: 5, completion: {success in
                if success{
                    print("success")
                }
                
            })
        }
        }
        }
    
        
    func notification(inSeconds: TimeInterval, completion:  @escaping (_ Success: Bool) -> () ){
            //if UIDevice.current.batteryState == batteryCharged {
                
                let notif = UNMutableNotificationContent()
                
                notif.title = "Battery Charged!"
                notif.body = "Your battery is %\(batteryCharged)"
        
                let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
                
                let request = UNNotificationRequest(identifier: "request", content: notif, trigger: notifTrigger)
                
                UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                    if error != nil {
                        print(error as Any)
                        completion(false)
                    }else{
                        completion(true)
                    }
                })
                
 
        }

  
 
}
