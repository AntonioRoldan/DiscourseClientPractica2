//
//  UserUpdateNameRequest.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 06/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserUpdateNameRequest : APIRequest {
    
    typealias Response = UserUpdateNameResponse
    
    let username : String
    let name : String
       
    init(_ username: String, _ name: String) {
        self.username = username
        self.name = name
    }
       
    var method: Method {
        .PUT
    }
    
    var path: String {
        return "/users/\(self.username).json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return ["name": self.name]
    }
    
    var headers: [String : String] {
        return [:]
    }
    
}
