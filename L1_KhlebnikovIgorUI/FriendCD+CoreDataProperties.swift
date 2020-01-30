//
//  FriendCD+CoreDataProperties.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 27.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//
//

import Foundation
import CoreData


extension FriendCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendCD> {
        return NSFetchRequest<FriendCD>(entityName: "FriendCD")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var avatarPath: String?
    @NSManaged public var deactivated: String?
    @NSManaged public var isOnline: Int64

}

extension FriendCD {
    func toCommonItem() -> User {
        return User(id: Int(self.id),
                    firstName: self.firstName ?? "",
                    lastName: self.lastName ?? "",
                    isOnline: Int(self.isOnline),
                    deactivated: self.deactivated,
                    avatarPath: self.avatarPath)
    }
}
