//
//  Excercise+CoreDataClass.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//
//

import Foundation
import CoreData


public class Score: NSManagedObject {
    var stats: Stats {
        get {
            Stats(sets: Int(self.sets) , reps: Int(self.reps), weight: self.weight)
        } set {
            self.reps = Int16(newValue.reps)
            self.sets = Int16(newValue.sets)
            self.weight = newValue.weight
        }
    }
    var volume: Int16 { return sets * reps * Int16(weight)}
}

extension Score: Encodable {
    func convertToJBScore() -> JBScore {
        JBScore(excercise: excercise, id: id, stats: stats)
        }
    private enum CodingKeys: String, CodingKey { case date, id, reps, sets, weight }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(date, forKey: .date)
        try container.encode(reps, forKey: .reps)
        try container.encode(sets, forKey: .sets)
        try container.encode(weight, forKey: .weight)
    }
}

