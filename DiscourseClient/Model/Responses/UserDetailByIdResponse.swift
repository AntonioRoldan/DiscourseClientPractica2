//
//  UserDetailByIdResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/09/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserIdResponse : Codable {
    enum CodingKeys : String, CodingKey {
        case id = "id"
        case username = "username"
        
    }
}
