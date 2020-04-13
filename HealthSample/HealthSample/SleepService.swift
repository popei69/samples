//
//  SleepService.swift
//  HealthSample
//
//  Created by Benoit PASQUIER on 13/04/2020.
//  Copyright © 2020 Benoit PASQUIER. All rights reserved.
//

import HealthKit

protocol SleepServiceProtocol {
    func requestSleepAuthorization(_ completion: @escaping (Bool, Error?) -> Void)
    func readSleep(from startDate: Date?, to endDate: Date?, completion: @escaping ([HKCategorySample], Error?) -> Void)
    func writeSleep(isAsleep: Bool, startDate: Date, endDate: Date, completion: @escaping (Bool, Error?) -> Void)
}

final class SleepService: SleepServiceProtocol {
    
    private let store: HKHealthStore
    
    init() {
        self.store = HKHealthStore()
    }
    
    func requestSleepAuthorization(_ completion: @escaping (Bool, Error?) -> Void) {
        
        if let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) {
            let setType = Set<HKSampleType>(arrayLiteral: sleepType)
            store.requestAuthorization(toShare: setType, read: setType, completion: completion)
        }
    }
        
    func readSleep(from startDate: Date?, to endDate: Date?, completion: @escaping ([HKCategorySample], Error?) -> Void) {
        
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
                completion([], error)
                return
            }
            
            if let result = result {
                
                // do something with those data
                let samples = result.compactMap({ $0 as? HKCategorySample })
                completion(samples, nil)
            }
        }
        
        // finally, we execute our query
        store.execute(query)
    }
    
    func writeSleep(isAsleep: Bool, startDate: Date, endDate: Date, completion: @escaping (Bool, Error?) -> Void) {
        
        let sleepValue: HKCategoryValueSleepAnalysis = isAsleep ? .asleep : .inBed
        
        // again, we define the object type we want
        guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
            return
        }
        
        // we create our new object we want to push in Health app
        let sample = HKCategorySample(type: sleepType, value: sleepValue.rawValue, start: startDate, end: endDate)
        
        // at the end, we save it
        store.save(sample, withCompletion: completion)
    }
    
}
