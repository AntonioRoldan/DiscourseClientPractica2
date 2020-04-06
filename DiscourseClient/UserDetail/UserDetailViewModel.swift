//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate : class {
    
}

protocol UserDetailViewDelegate : class {
    
}

class UserDetailViewModel {
    weak var coordinatorDelegate : UserDetailCoordinatorDelegate?
    weak var viewDelegate : UserDetailViewDelegate?
    let username : String
    let dataManager: UserDetailDataManager
    init(username: String, userDetailDataManager: UserDetailDataManager) {
           self.username = username
           self.dataManager = userDetailDataManager
    }
}
