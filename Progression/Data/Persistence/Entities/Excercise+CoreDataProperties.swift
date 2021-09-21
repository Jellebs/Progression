//
//  Excercise+CoreDataProperties.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//
//

import Foundation
import CoreData


extension Excercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Excercise> {
        return NSFetchRequest<Excercise>(entityName: "Excercise")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var scores: NSSet?

}

// MARK: Generated accessors for score
extension Excercise {

    @objc(addScoreObject:)
    @NSManaged public func addToScore(_ value: Score)

    @objc(removeScoreObject:)
    @NSManaged public func removeFromScore(_ value: Score)

    @objc(addScore:)
    @NSManaged public func addToScore(_ values: NSSet)

    @objc(removeScore:)
    @NSManaged public func removeFromScore(_ values: NSSet)

}

extension Excercise : Identifiable {

}
