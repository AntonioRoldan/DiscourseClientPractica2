//
//  UserDetailResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailResponse : Codable {
    let username : String
    init(username: String) {
        self.username = username
    }
}
