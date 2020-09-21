//
//  UserByIdResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 21/09/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct UserDetailByIdResponse : Codable {
    let username: String
    let topicCount: Int
    let postCount: Int
    let likesCount: Int
    let likesGivenCount: Int
    let name: String
    let postsReadCount: String
    let lastSeenAt: String
    let createdAt: String
    enum CodingKeys : String, CodingKey {
        case topicCount = "topic_count"
        case postCount = "post_count"
        case name = "name"
        case username = "username"
        case likesCount = "like_count"
        case likesGivenCount = "likes_given_count"
        case postsReadCount = "posts_read_count"
        case lastSeenAt = "last_seen_at"
        case createdAt = "created_at"
        
    }
}
