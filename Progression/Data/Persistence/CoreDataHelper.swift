
import Foundation
import CoreData
final class CoreDataHelper {
    typealias DBObject = NSManagedObject
    typealias DBPredicate = NSPredicate
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    static let shared = CoreDataHelper()
    private init() {    }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Progression")
        container.loadPersistentStores { (StoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Didn't manage to load persistent stores: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    func saveContext(errorMessage: String) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                if let error = error as NSError? {
                    fatalError("\(errorMessage): \(error), \(error.userInfo)")
                }
            }
        }
    }
}

extension CoreDataHelper: DBHelper {
    func create<T: NSManagedObject>(_ object: T) {
        saveContext(errorMessage: "Didn't manage to save new creation in context")
    }
    func read<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, limit: Int?) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    func readFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try context.fetch(request)
            return .success(result.first as? T)
        } catch {
            return .failure(error)
        }
    }
    
    func update<T: NSManagedObject>(_ object: T) {
        saveContext(errorMessage: "Didn't manage to update context")
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
        update(object)
    }
    
    
    
    
}

