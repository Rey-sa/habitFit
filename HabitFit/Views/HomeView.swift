//
//  HomeView.swift
//  HabitFit
//
//  Created by Saskia Rey on 10.04.25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Query private var habits: [Habit]
    @Environment(\.modelContext) private var modelContext
    @StateObject private var healthKitManager = HealthKitManager()
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Steps today: \(healthKitManager.stepsToday)")
                    .font(.title2)
                    .padding()
                List {
                    ForEach(habits) { habit in
                        HStack {
                            VStack(alignment: .leading){
                                Text(habit.name)
                                Text("\(habit.completedCount)/\(habit.goalCount)")
                                    .font(.caption)
                                    .foregroundStyle(.gray)
                            }
                            Spacer()
                            Button(action: {
                                habit.completeHabit()
                            }) {
                                Image(systemName: habit.completedCount >= habit.goalCount ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(.green)
                            }
                        }
                    }
                    .onAppear {
                        healthKitManager.requestAuthorization()
                    }
                }
                .navigationTitle("My Habits")
                .toolbar {
                    Button("Add"){
                        let newHabit = Habit(name: "New Habit", goalCount: 3)
                        modelContext.insert(newHabit)
                    }
                }
            }
        }
    }
}
