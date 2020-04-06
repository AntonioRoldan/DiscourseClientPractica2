//
//  UserDetailDataManager.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailDataManager : class {
    func fetchDetail(username: String, completion: @escaping (Result<UserDetailResponse, Error>) -> ())
    func updateName(username: String, name: String, completion: @escaping (Result<Void, Error>) -> ())
}
