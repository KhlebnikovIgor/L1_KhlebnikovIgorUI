//
//  CoreDataStack.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 24.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack{
    static let shared = CoreDataStack()
    private let storeContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        storeContainer = NSPersistentContainer(name: "VKDatabase")
        storeContainer.loadPersistentStores { (_, error) in }
        context = storeContainer.viewContext
    }

}
