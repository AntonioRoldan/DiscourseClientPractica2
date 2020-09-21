//
//  UsersResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UsersResponse : Codable {
    let directoryItems: [DirectoryItem]
    enum CodingKeys : String, CodingKey {
        case directoryItems = "directory_items"
    }
}

struct DirectoryItem : Codable {
    let user: User
//    let likesReceived: Int
//    let likesGiven: Int
//    let topicsCreated: Int
//    let postsRead: Int
//    let postCount: String
//    enum CodingKeys: String, CodingKey {
//        case user = "user"
//        case likesReceived = "likes_received"
//        case likesGiven = "likes_given"
//        case topicsCreated = "topic_count"
//        case postsRead = "posts_read"
//        case postCount = "post_count"
//    }
}

struct User : Codable {
    let id: Int
    let userName: String
    var imageURL: String
    // NOTE: The following fields do not belong to the API's JSON response but we are taking them from directory Items so we can pass this object with its corresponding data to UsersDetail 
    
    enum CodingKeys : String, CodingKey {
           case id = "id"
           case userName = "username"
           case imageURL = "avatar_template"
    }
}


