//
//  UserDetailResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailResponse : Codable {
    let user : UserDetail
    
}

struct UserDetail : Codable {
    let id : Int
    let username : String
    let name: String
    let canEditName: Bool
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case username = "username"
        case name = "name"
        case canEditName = "can_edit_name"
    }
}
