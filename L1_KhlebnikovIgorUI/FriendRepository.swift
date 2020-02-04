//
//  FriendRepository.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 24.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import CoreData

protocol Repository{
    associatedtype Entity
    func getAll()->[Entity]
    func get(id: Int)->Entity?
    func update(entity: Entity) ->Bool
    func create(entity: Entity) ->Bool
    func delete(entity: Entity) ->Bool
}

class FriendRepository: Repository {
    
    //    typealias Entity = User
    let context: NSManagedObjectContext
    //
    init(stack: CoreDataStack){
        self.context = stack.context
    }
    
    func getAll() -> [User] {
        return query(with: nil, sortDescriptors: [NSSortDescriptor(key: "id", ascending: true)])
    }
    
    func get(id: Int) -> User? {
        return query(with: NSPredicate(format: "id = %@", "\(id)")).first
    }
    
    func update(entity: User) -> Bool {
        guard let objectToUpdate = queryCD(with: NSPredicate(format: "id = %@", "\(entity)")).first
            else { return false }
        if objectToUpdate.firstName != entity.firstName{
            objectToUpdate.setValue(entity.firstName, forKey: "firstName")
        }
        if objectToUpdate.lastName != entity.lastName{
            objectToUpdate.setValue(entity.lastName, forKey: "lastName")
        }
        if objectToUpdate.deactivated != entity.deactivated{
            objectToUpdate.setValue(entity.deactivated, forKey: "deactivated")
        }
        if objectToUpdate.isOnline != entity.isOnline{
            objectToUpdate.setValue(entity.isOnline, forKey: "online")
        }
        if objectToUpdate.avatarPath != entity.avatarPath{
            objectToUpdate.setValue(entity.avatarPath, forKey: "avatarPath")
        }
        
        return save()
    }
    
    func create(entity: User) -> Bool {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "FriendCD", in: context)
            else {return false}
        
        let friendEntity = NSManagedObject(entity: entityDescription, insertInto: context)
        friendEntity.setValue(entity.id, forKey: "id")
        friendEntity.setValue(entity.firstName, forKey: "firstName")
        friendEntity.setValue(entity.lastName, forKey: "lastName")
        friendEntity.setValue(entity.deactivated, forKey: "deactivated")
        friendEntity.setValue(entity.isOnline, forKey: "isOnline")
        friendEntity.setValue(entity.avatarPath, forKey: "avatarPath")
        
        return save()
    }
    
    func delete(entity: User) -> Bool {
        guard let objectToDelete = queryCD(with: NSPredicate(format: "id = %@", "\(entity)")).first
            else { return false }
        
        context.delete(objectToDelete)
        return true
    }
    
    private func queryCD (with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]? = nil) -> [FriendCD]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendCD")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do{
            return try (context.fetch(fetchRequest) as? [FriendCD] ?? [])
        } catch{
            return []
        }
    }
    
    private func query (with predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]? = nil) -> [User]{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendCD")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        do{
            let objects = try context.fetch(fetchRequest) as? [FriendCD]
            return objects?.map{ $0.toCommonItem() } ?? []
        } catch{
            return []
        }
    }
    
    private func save() ->Bool {
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    
    
    
    
}
