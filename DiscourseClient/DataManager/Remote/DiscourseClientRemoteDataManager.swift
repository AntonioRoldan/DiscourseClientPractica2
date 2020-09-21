//
//  DiscourseClientRemoteDataManager.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Protocolo que contiene todas las llamadas remotas de la app
protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping(Result<Void, Error>) -> ())
    func fetchAllUsers(completion: @escaping (Result<UsersResponse, Error>) -> ())
    func fetchUser(username: String, completion: @escaping(Result<UserDetailResponse, Error>) -> ())
    
    func fetchUserById(id: Int, completion: @escaping(Result<UserDetailByIdResponse, Error>) -> ())
    
    func updateName(username: String, name: String, completion: @escaping(Result<Void, Error>) -> ())
    func fetchCategories(completion: @escaping(Result<CategoriesResponse, Error>) -> ())
}
