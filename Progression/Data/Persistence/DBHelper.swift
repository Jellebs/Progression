//
//  DBHelper.swift
//  Progression
//
//  Created by Jesper Bertelsen on 29/08/2021.
//

import Foundation

protocol DBHelper {
    associatedtype DBObject
    associatedtype DBPredicate
    
    func create(_ object: DBObject)
    func read(_ objectType: DBObject.Type, predicate: DBPredicate?, limit: Int?) -> Result<[DBObject], Error>
    func readFirst(_ objectType: DBObject.Type, predicate: DBPredicate?) -> Result<DBObject?, Error>
    func update(_ object: DBObject)
    func delete(_ object: DBObject)
}

extension DBHelper {
    func read(_ objectType: DBObject.Type, predicate: DBPredicate? = nil, limit: Int? = nil) -> Result<[DBObject], Error> {
        read(objectType, predicate: predicate, limit: limit)
    }
}
