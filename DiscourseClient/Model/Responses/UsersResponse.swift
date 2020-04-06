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
}

struct User : Codable {
    let id: Int
    let userName: String
    var imageURL: String
    enum CodingKeys : String, CodingKey {
           case id = "id"
           case userName = "username"
           case imageURL = "avatar_template"
       }
}


