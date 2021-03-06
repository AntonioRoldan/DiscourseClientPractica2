//
//  UsersDataManager.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UsersDataManager {
    func fetchUsers(completion: @escaping (Result<UsersResponse, Error>) -> ())
}
