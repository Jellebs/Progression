//
//  ViewModel.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import Foundation
import SwiftUI
final class ViewModel: ObservableObject {
    
    @Published var exercises: [Excercise] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    @Published var scores: [JBScore] = [
    ] 
    @Published var newExerciseIsActive: Bool = false
    @Published var newScoreIsActive: Bool = false
    //Excercise
    @Published var exerciseViewIsActive: Bool = false
    @Published var graphIsShown: Bool = false
    @Published var currentExercise: Excercise?
    //DetailScore
    @Published var detailedScore: JBScore = JBScore()
    @Published var detailViewIsActive: Bool = false
    let dataManager: DataManager = DataManager.shared
    
    init() {
        fetchScores()
        fetchExercises()
        if !hasConfigured() && exercises.count == 0 {
            exerciseViewIsActive = true
        }
    }
    
    //Excercise
    func fetchExercises() {
        exercises = dataManager.exercises
    }
    func addExcercise(name: String) {
        dataManager.addExercise(name: name)
        fetchExercises()
    }
    
    //Score
    func fetchScores() {
        scores = dataManager.fetchScores()
    }
    
    func saveScore(score: JBScore) {
        guard dataManager.fetchScore(for: score) == nil else {
            return dataManager.update(for: score)
        }
        dataManager.addScore(score: score)
        fetchScores()
    }
    
    
    func addScore(excercise: Excercise) {
        let score = JBScore(excercise: excercise, id: UUID(), stats: Stats(sets: 0, reps: 0, weight: 0))
        scores.append(score)
    }
    
    func deleteScore(score: JBScore) {
        dataManager.delete(for: score)
        fetchScores()
        fetchExercises()
        detailViewIsActive.toggle()
    }
    func hasConfigured() -> Bool {
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "hasConfigured") { return true }
        else { return false }
    }
    func configure() {
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: "hasConfigured")
    }
    
}
