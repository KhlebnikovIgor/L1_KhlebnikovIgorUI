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
    case decodableError(message: String)
}


class VKApi{
    let vkURL = "https://api.vk.com/method/"
    
    typealias Out = Swift.Result
    
    func requestServer<T: Decodable>(requestURL: String,
                                     method: HTTPMethod = .get,
                                     params: Parameters,
                                     completion: @escaping(Out<[T], Error>) -> Void) {
        
        Alamofire.request(requestURL,
                          method: method,
                          parameters: params)
            .responseData{ (response) in
                switch response.result {
                case .failure(let error):
                    completion(.failure(RequestError.failedRequest(message: error.localizedDescription)))
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(CommonResponse<T>.self, from: data)
                        completion(.success(result.response.items))
                    } catch let error {
                        completion(.failure(RequestError.decodableError(message: error.localizedDescription)))
                    }
                }
        }
    }
    
    //получение списка друзей
    func getFriends(token : String, completion: @escaping(Out<[User], Error>) -> Void ){
        let requestURL = vkURL  + "friends.get"
        let params = ["access_token": token,
                      "order": "name",
                      "fields": "city,domain,photo_100",
                      "v":"5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) {completion($0)}
    }
    
    
    //получение списка фотографий
    func getPhotos(token : String, completion: @escaping (Out<[Photo], Error>)->Void){
        let requestURL = vkURL  + "photos.get"
        let params = ["access_token": token,
                      "album_id": "wall",
                      "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) {completion($0)}
    }
    
    //получение списка групп
    func getGroups(token : String, completion: @escaping (Out<[Group], Error>)->Void){
        let requestURL = vkURL  + "groups.get"
        let params = ["access_token": token,
                      "extended": "1",
                      "fields": "photo_100",//"city,domain",
            "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) {completion($0)}
    }
    
    //поиск групп по заданной подстроке
    func searchGroups(token : String, searchText: String, completion: @escaping (Out<[Group], Error>)->Void){
        let requestURL = vkURL  + "groups.search"
        let params = ["access_token": token,
                      "q": searchText,
                      "type": "page",//тип сообщества
            "v": "5.103"]
        
        requestServer(requestURL: requestURL, method: .post, params: params) {completion($0)}
    }
    
}
