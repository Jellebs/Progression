//
//  ViewModel.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import Foundation
import SwiftUI
final class ViewModel: ObservableObject {
    
    @Published var excercises: [Excercise] = []
    @Published var scores: [JBScore] = [
    ] 
    @Published var newExcerciseIsActive: Bool = false
    @Published var newScoreIsActive: Bool = false
    //Excercise
    @Published var excerciseViewIsActive: Bool = false
    @Published var graphIsShown: Bool = false
    @Published var currentExcercise: Excercise?
    //DetailScore
    @Published var detailedScore: JBScore = JBScore()
    @Published var detailViewIsActive: Bool = false
    let dataManager: DataManager = DataManager.shared
    
    init() {
        fetchScores()
        fetchExcercises()
    }
    
    //Excercise
    func fetchExcercises() {
        excercises = dataManager.excercises
    }
    func addExcercise(name: String) {
        dataManager.addExcercise(name: name)
        fetchExcercises()
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
        fetchExcercises()
    }
    
    
    func addScore(excercise: Excercise) {
        let score = JBScore(excercise: excercise, id: UUID(), stats: Stats(sets: 0, reps: 0, weight: 0))
        scores.append(score)
    }
    
    func deleteScore(score: JBScore) {
        dataManager.delete(for: score)
        fetchScores()
    }
    
}
