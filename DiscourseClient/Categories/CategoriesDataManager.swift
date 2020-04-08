//
//  CategoriesDataManager.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 08/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesDataManager {
    func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> ())
}
