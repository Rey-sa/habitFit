//
//  HealthKitManager.swift
//  HabitFit
//
//  Created by Saskia Rey on 10.04.25.
//
import HealthKit
import Foundation

class HealthKitManager: ObservableObject {
    private let store = HKHealthStore()
    @Published var stepsToday = 0
    
    var useMockData = true
    
    func requestAuthorization() {
        if useMockData {
            fetchStepsMock()
        } else {
            let types = Set([HKQuantityType.quantityType(forIdentifier: .stepCount)!])
            store.requestAuthorization(toShare: nil, read: types){ success, _ in
                if success {
                    self.fetchSteps()
                }
            }
        }
    }
    
    func fetchSteps() {
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: Date())
        let predicate = HKQuery.predicateForSamples(withStart: start, end: Date(), options: .strictStartDate)
        
        let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum){_, result, _ in
            let steps = result?.sumQuantity()?.doubleValue(for: HKUnit.count()) ?? 0
            DispatchQueue.main.async {
                self.stepsToday = Int(steps)
            }
        }
        store.execute(query)
    }
    
    func fetchStepsMock(){
        let steps = MockHealthKitData.stepsData
        DispatchQueue.main.async {
            self.stepsToday = Int(steps.last?.quantity.doubleValue(for: .count()) ?? 0)
        }
    }
}
