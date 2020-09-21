//
//  UserDetailRequest.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailByIdRequest : APIRequest {
    
    typealias Response = UserDetailByIdResponse
    let id : Int
    
    init(_ id: Int) {
        self.id = id
    }
    
    var method: Method {
        .GET
    }
    
    var path: String {
        return "/admin/users/\(String(self.id)).json"
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
