//
//  HabitFitApp.swift
//  HabitFit
//
//  Created by Saskia Rey on 08.04.25.
//

import SwiftUI
import SwiftData

@main
struct HabitFitApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .modelContainer(for: Habit.self)
    }
}
