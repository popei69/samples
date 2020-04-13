//
//  ViewController.swift
//  HealthSample
//
//  Created by Benoit PASQUIER on 11/04/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    // can be injected
    var sleepService: SleepServiceProtocol? = SleepService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestAuthorization()
    }
    
    func requestAuthorization() {
        sleepService?.requestSleepAuthorization{ (success, error) in
            if !success || error != nil {
                // handle error
                return
            }
            
            // handle success
        }
    }
    
    func readSleep(from startDate: Date?, to endDate: Date?) {
        
        sleepService?.readSleep(from: startDate, to: endDate, completion: { (samples, error) in
            guard error == nil else {
                // handle error
                return
            }
            
            // print those values
            samples.forEach { sample in 
                guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                        return
                    }
                    
                    let isAsleep = sleepValue == .asleep
                    
                print("HealthKit sleep \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
            }
        })
    }

    func writeAsleep(from startDate: Date, to endDate: Date) {
        
        sleepService?.writeSleep(isAsleep: true, startDate: startDate, endDate: endDate, completion: { (success, error) in
            // handler completino
        })
    }

}

