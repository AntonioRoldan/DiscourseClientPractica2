//
//  UserDetailRequest.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailRequest : APIRequest {
    
    typealias Response = UserDetailResponse
    let username : String
    
    init(_ username: String) {
        self.username = username
    }
    
    var method: Method {
        .GET
    }
    
    var path: String {
        return "/users/\(self.username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    
}
