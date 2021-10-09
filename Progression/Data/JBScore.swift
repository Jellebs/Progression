//
//  JBExcercise.swift
//  Progression
//
//  Created by Jesper Bertelsen on 26/08/2021.
//

import Foundation
import SwiftUI

class JBScore: Identifiable, ObservableObject {
    @EnvironmentObject var viewModel: ViewModel
    var id: UUID
    var date: Date
    var excercise: Excercise
    var volume: Int {
        return sets * reps * Int(weight)
    }
    var sets: Int = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    var reps: Int = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    var weight: Double = 0 {
        didSet {
            objectWillChange.send()
        }
    }
    var stats: Stats {
        get {
            Stats(sets: sets, reps: reps, weight: weight)
        } set {
            sets = newValue.sets
            reps = newValue.reps
            weight = newValue.weight
        }
    }
    init(excercise: Excercise = Excercise(), id: UUID = UUID(), stats: Stats = Stats(sets: 0, reps: 0, weight: 0)) {
        self.date = Date()
        self.excercise = excercise
        self.sets = stats.sets
        self.reps = stats.reps
        self.weight = stats.weight
        self.id = id
    }
}
class Stats: Equatable {
    static func == (lhs: Stats, rhs: Stats) -> Bool {
        return lhs.reps == rhs.reps && lhs.sets == rhs.sets && lhs.weight == rhs.weight
    }

    var sets: Int
    var reps: Int
    var weight: Double
    var volume: Int { return sets * reps * Int(weight) }
    
    init(sets: Int, reps: Int, weight: Double) {
        self.sets = sets
        self.reps = reps
        self.weight = weight
    }
}

