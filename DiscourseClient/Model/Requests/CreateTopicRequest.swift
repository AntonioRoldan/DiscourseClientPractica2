//
//  CreateTopicRequest.swift
//
//  Created by Ignacio Garcia Sainz on 17/07/2019.
//  Copyright © 2019 KeepCoding. All rights reserved.
//  Revisado por Roberto Garrido on 8 de Marzo de 2020
//

import Foundation

// TODO: Implementar las propiedades de esta request
struct CreateTopicRequest: APIRequest {
    
    typealias Response = AddNewTopicResponse
    
    let title: String
    let raw: String
    let createdAt: String
    
    init(title: String,
         raw: String,
         createdAt: String) {
        self.title = title
        self.raw = raw
        self.createdAt = createdAt
    }
    
    var method: Method {
        .POST
    }
    
    var path: String {
        "/posts.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [
            "title": self.title,
            "raw": self.raw,
            "created_at": self.createdAt
        ]
    }
    
    var headers: [String : String] {
        return [:]
    }
}
