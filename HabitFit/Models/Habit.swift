//
//  Untitled.swift
//  HabitFit
//
//  Created by Saskia Rey on 10.04.25.
//
import Foundation
import SwiftData

@Model
class Habit {
    var name: String
    var goalCount: Int
    var completedCount: Int
    var dateAdded: Date
    
    init(name: String, goalCount: Int){
        self.name = name
        self.goalCount = goalCount
        self.completedCount = 0
        self.dateAdded = Date()
    }
    
    func completeHabit(){
        if completedCount < goalCount {
            completedCount += 1
        }
    }

}
