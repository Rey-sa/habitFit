//
//  MockHealthKitData.swift
//  HabitFit
//
//  Created by Saskia Rey on 10.04.25.
//
import Foundation
import HealthKit

// Mocked HealthKit Data
struct MockHealthKitData {
    // Beispiel für Schritte (Step Count)
    static let stepsData: [HKQuantitySample] = {
        var samples: [HKQuantitySample] = []
        
        let now = Date()
        for i in 1...5 {
            let sample = HKQuantitySample(type: .quantityType(forIdentifier: .stepCount)!,
                                          quantity: HKQuantity(unit: .count(), doubleValue: Double(i * 100)),
                                          start: now.addingTimeInterval(Double(-i * 60 * 60)), // 1, 2, 3 Stunden zurück
                                          end: now.addingTimeInterval(Double(-i * 60 * 60 + 60))) // 1, 2, 3 Stunden zurück plus 1 Minute
            samples.append(sample)
        }
        return samples
    }()
    
    // Beispiel für Kalorienverbrauch (Energy burned)
    static let caloriesData: [HKQuantitySample] = {
        var samples: [HKQuantitySample] = []
        
        let now = Date()
        for i in 1...5 {
            let sample = HKQuantitySample(type: .quantityType(forIdentifier: .activeEnergyBurned)!,
                                          quantity: HKQuantity(unit: .kilocalorie(), doubleValue: Double(i * 50)),
                                          start: now.addingTimeInterval(Double(-i * 60 * 60)),
                                          end: now.addingTimeInterval(Double(-i * 60 * 60 + 60)))
            samples.append(sample)
        }
        return samples
    }()
}
