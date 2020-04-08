//
//  CategoriesRequest.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 08/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoriesRequest : APIRequest {
    typealias Response = CategoriesResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/categories.json"
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
