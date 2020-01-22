//
//  Group.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 17.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation


struct GroupJson: Codable {
    let response: ResponseGroup
}


struct ResponseGroup: Codable {
    let count: Int
    let items: [Group]
}


struct Group: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: String
    let isAdmin, isMember, isAdvertiser: Int
    let photo100/*photo50, , photo200*/: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
     //   case photo50 = "photo_50"
        case photo100 = "photo_100"
       // case photo200 = "photo_200"
    }
}

//enum TypeEnum: String, Codable {
//    case page = "page"
//}
