//
//  Score+CoreDataProperties.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var date: Date
    @NSManaged public var id: UUID
    @NSManaged public var reps: Int16
    @NSManaged public var sets: Int16
    
    @NSManaged public var weight: Double
    @NSManaged public var excercise: Excercise

}

extension Score : Identifiable {
    
}
