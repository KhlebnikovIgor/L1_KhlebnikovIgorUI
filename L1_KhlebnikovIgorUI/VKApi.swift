//
//  VKApi.swift
//  L1_KhlebnikovIgorUI
//
//  Created by Игорь Хлебников on 15.01.2020.
//  Copyright © 2020 Igor. All rights reserved.
//

import Foundation
import Alamofire


enum RequestError: Error{
    case failedRequest(message: String)
    case decodableError
}


class VKApi{
    let vkURL = "https://api.vk.com/method/"
    
    func requestServer<T: Decodable>(requestURL: String,
                       params: Parameters,
                       completion: @escaping(Swift.Result<T, Error>) -> Void) {
        
        Alamofire.request(requestURL,
                          method: .post,
                          parameters: params)
            .responseData{ (response) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(RequestError.failedRequest(message: error.localizedDescription)))
                case .success(let data):
                    do {
                        let response = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(response))
                    } catch let error {
                        completion(.failure(RequestError.decodableError))
                    }
                }
        }
    }
    
    //получение списка друзей
    func getFriends(token : String, completion: @escaping (Swift.Result<[User], Error>)->Void){
        let requestURL = vkURL  + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "fields": "city,domain,photo_100",
                      "v":"5.103"]
    
        requestServer(requestURL: requestURL, params: params) { (users: Swift.Result<UserJson, Error>) in
            switch users {
            case .failure(let error):
                completion(.failure(error))
            case .success(let user):
                completion(.success(user.response.items))
            }
        }
    }
  
  
    //получение списка фотографий
    func getPhotos(token : String, completion: @escaping (Swift.Result<[Photo], Error>)->Void){
        let requestURL = vkURL  + "photos.get"
        let params = ["access_token": token,
                      "album_id": "wall",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (photos: Swift.Result<PhotoJson, Error>) in
            switch photos {
            case .failure(let error):
                completion(.failure(error))
            case .success(let photo):
                completion(.success(photo.response.items))
            }
        }
    }
    
    //получение списка групп
    func getGroups(token : String, completion: @escaping (Swift.Result<[Group], Error>)->Void){
        let requestURL = vkURL  + "groups.get"
        let params = ["access_token": token,
                      "extended": "1",
                      "fields": "photo_100",//"city,domain",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (groups: Swift.Result<GroupJson, Error>) in
            switch groups {
            case .failure(let error):
                completion(.failure(error))
            case .success(let group):
                completion(.success(group.response.items))
            }
        }
  }
    
    //поиск групп по заданной подстроке
    func searchGroups(token : String, searchText: String, completion: @escaping (Swift.Result<[Group], Error>)->Void){
        let requestURL = vkURL  + "groups.search"
        let params = ["access_token": token,
                      "q": searchText,
                      "type": "page",//тип сообщества
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, params: params) { (groups: Swift.Result<GroupJson, Error>) in
            switch groups {
            case .failure(let error):
                completion(.failure(error))
            case .success(let group):
                completion(.success(group.response.items))
            }
        }
    }
    
}
