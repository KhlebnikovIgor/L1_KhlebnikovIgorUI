//
//  FrendsPresenter.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 30.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation


protocol FriendListPreseneter {
    func getFriendList(completion: @escaping(Swift.Result<[User], Error>)->())
}

class FriendListPresenterImplementation/*<T: Repository>*/ : FriendListPreseneter{
    
    
    let vkAPI: VKApi
    let database: UsersRepositoryRealm//FriendRepository
    
    init(database: UsersRepositoryRealm/*FriendRepository*/, api: VKApi) {
        self.vkAPI = api
        self.database = database
    }
    
    func getFriendList(completion: @escaping(Swift.Result<[User], Error>)->()) {
        vkAPI.getFriends(token: Session.shared.token) { result in
            switch result {
            case  .success(let users)://Добавили в базу друзей
                self.database.addUsers(users: users)//users.forEach{ database.create(entity: $0) }
                do{//Отображаем друзей из базы
                    try completion(.success(self.database.getAllUsers().map{$0.toModel()}))//    users
                }
                catch{
                    print (error)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
