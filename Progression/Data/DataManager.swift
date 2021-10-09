//
//  DataManager.swift
//  Progression
//
//  Created by Jesper Bertelsen on 29/08/2021.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared: DataManager = DataManager()
    //CoreData
    var dbHelper = CoreDataHelper.shared
    var scores: [JBScore] = []
    var exercises: [Excercise] = []
    
    init() {
        scores = fetchScores()
        exercises = fetchExercises()
    }
    
    func encode() {
        do {
            let name = "Test.json"
            let jsonData = try JSONEncoder().encode(exercises)
            let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let documentUrl = URL(fileURLWithPath: documentPath).appendingPathComponent(name)
            print(jsonData)
            try jsonData.write(to: documentUrl)
        } catch {
            print("Error fetching data from CoreData", error)
        }
    }
    
    func fetchExercises() -> [Excercise] {
        let result: Result<[Excercise], Error> = dbHelper.read(Excercise.self, predicate: nil, limit: nil)
        switch result {
        case .success(let scoreEntities):
            return scoreEntities
        case .failure(let error):
            fatalError("Error found while trying to fetch activities: \(error.localizedDescription)")
        }
    }
    
    func addExercise(name: String) {
        let entity = Excercise.entity()
        let newExercise = Excercise(entity: entity, insertInto: dbHelper.context)
        newExercise.id = UUID()
        newExercise.name = name
        dbHelper.create(newExercise)
        exercises = fetchExercises()
    }
    func deleteExercise(excercise: Excercise) {
        dbHelper.delete(excercise)
    }
    private func fetchExercise(with id: UUID) -> Excercise? {
        let predicate = NSPredicate(format: "id == %@", id as CVarArg)
        let result = dbHelper.readFirst(Excercise.self, predicate: predicate)
        switch result {
        case .success(let excercise):
            return excercise
        case .failure(_):
            return nil
        }
    }
    
    //Score
    func fetchScores(withPredicate: Bool = true) -> [JBScore] {
        let predicate: NSPredicate? = {
            let date = Date()
            if withPredicate {
                let calendar = Calendar.current
                let startDate = calendar.startOfDay(for: date)
                let endDate = calendar.date(byAdding: .day, value: 1, to: startDate)
                return NSPredicate(format: "date >= %@ AND date < %@", startDate as CVarArg, endDate! as CVarArg)
            } else {
                return nil
            }
        }()
        
        let result: Result<[Score], Error> = dbHelper.read(Score.self, predicate: predicate, limit: nil)
        
        switch result {
        case .success(let scoreEntities):
            return scoreEntities.map { $0.convertToJBScore() }
        case .failure(let error):
            fatalError("Error found while trying to fetch activities: \(error.localizedDescription)")
        }
    }
    func fetchScore(for score: JBScore) -> Score? {
        let predicate = NSPredicate(format: "id == %@", score.id as CVarArg)
        let result = dbHelper.readFirst(Score.self, predicate: predicate)
        switch result {
        case .success(let excercise):
            return excercise
        case .failure(_):
            return nil
        }
    }
    func update(for score: JBScore) {
        guard let data = fetchScore(for: score) else { return }
        data.reps = Int16(score.reps)
        data.sets = Int16(score.sets)
        data.weight = score.weight
        dbHelper.update(data)
        exercises = fetchExercises()
    }
    func delete(for score: JBScore) {
        guard let score = fetchScore(for: score) else { return }
        dbHelper.delete(score)
        scores = fetchScores()
    }
    func edit(for score: Score) { dbHelper.update(score)}
    func addScore(score: JBScore) {
        let entity = Score.entity()
        let newScore = Score(entity: entity, insertInto: dbHelper.context)
        newScore.date = Date()
        newScore.stats = score.stats
        guard let exercise = fetchExercise(with: score.excercise.id) else { return }
        newScore.excercise = exercise
        newScore.id = UUID()
        dbHelper.create(newScore)
        dbHelper.saveContext(errorMessage: "Failed to add exercise")
    }
}
