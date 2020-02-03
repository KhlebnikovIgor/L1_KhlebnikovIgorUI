//
//  FriendsCofigurator.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 30.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import UIKit

protocol FriendsConfigurator {
    func configure(view: FriendsController)
}

class FriendsConfiguratorImplementation: FriendsConfigurator{
    func configure(view: FriendsController) {
        view.presenter = FriendsPresenterImplementation(database: UsersRepositoryRealmImplementations(), view: view)
    }
}
