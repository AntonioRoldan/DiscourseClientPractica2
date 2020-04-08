//
//  CategoriesResponse.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 08/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

struct CategoriesResponse : Codable {
    let categoryList : CategoryList
    enum CodingKeys : String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let categories : [Category]
}

struct Category : Codable {
    let name: String
}
