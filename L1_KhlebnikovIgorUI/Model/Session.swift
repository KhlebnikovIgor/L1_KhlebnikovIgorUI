//
//  Session.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 13.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation

class Session{
    static let instance = Session()
    private init() {}
    var token = ""
    var userId = 0
}
