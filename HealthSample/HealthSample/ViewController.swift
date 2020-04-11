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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestSleepAuthorization()
    }
    
    func requestSleepAuthorization() {
        let healthStore = HKHealthStore()
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            let setType = Set<HKSampleType>(arrayLiteral: sleepType)
            healthStore.requestAuthorization(toShare: setType, read: setType) { (success, error) in
                
                if !success || error != nil {
                    // handle error
                    return
                }
                
                // handle success
            }
        }
    }
    
    func readSleep(from startDate: Date?, to endDate: Date?) {
        
        let healthStore = HKHealthStore()
        
        // first, we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        // we create a predicate to filter our data
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: .strictStartDate)
    
        // I had a sortDescriptor to get the recent data first
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
    
        // we create our query with a block completion to execute
        
        let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: 30, sortDescriptors: [sortDescriptor]) { (query, result, error) in
            if error != nil {
                // handle error
                return
            }
            
            if let result = result {
                
                // do something with those data
                result
                    .compactMap({ $0 as? HKCategorySample })
                    .forEach({ sample in 
                        guard let sleepValue = HKCategoryValueSleepAnalysis(rawValue: sample.value) else {
                            return
                        }
                        
                        let isAsleep = sleepValue == .asleep
                        
                        print("HealthKit sleep \(sample.startDate) \(sample.endDate) - source \(sample.sourceRevision.source.name) - isAsleep \(isAsleep)")
                    })
            }
        }
    
        // finally, we execute our query
        healthStore.execute(query)
    }

    func writeSleep(_ sleepAnalysis: HKCategoryValueSleepAnalysis, startDate: Date, endDate: Date) {
        
        let healthStore = HKHealthStore()
        
        // again, we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        // we create our new object we want to push in Health app
        let sample = HKCategorySample(type: sleepType, value: sleepAnalysis.rawValue, start: startDate, end: endDate)
        
        // at the end, we save it
        healthStore.save(sample) { (success, error) in
            guard success && error == nil else {
                // handle error
                return
            }
            
            // success!
        }
    }

}

