//
//  Excercise+CoreDataClass.swift
//  Progression
//
//  Created by Jesper Bertelsen on 06/09/2021.
//
//

import Foundation
import CoreData
import SwiftUI

@objc(Excercise)
public class Excercise: NSManagedObject {
}
extension Excercise: Encodable {
    private enum CodingKeys: String, CodingKey { case name, id, scores, uuid }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        guard let scores = scores?.allObjects as? [Score] else { print("Failed"); return }
        try container.encode(scores, forKey: .scores)
       
//        let scores = scores?.allObjects as? [Score]
//        print(scores)
    }
}
