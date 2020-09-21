//
//  UsersViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

protocol UsersCoordinatorDelegate : class {
    func didSelect(user: User)
}

protocol UsersViewDelegate : class {
    func usersFetched()
    func errorFetchingUsers(_ errorMessage: String)
}

class UsersViewModel {
    weak var coordinatorDelegate : UsersCoordinatorDelegate?
    weak var viewDelegate : UsersViewDelegate?
    let dataManager: UsersDataManager
    var userViewModels: [UserCellViewModel] = []
    init(usersDataManager: UsersDataManager){
        self.dataManager = usersDataManager
    }
    
    func viewWasLoaded() {
        dataManager.fetchUsers { [weak self] result in
            switch result {
            case .success(let usersResponse):
                let users = usersResponse.directoryItems
                self?.userViewModels = users.map({ directoryItem -> UserCellViewModel in
                    let user = directoryItem.user
                    var userWithURLParametersSet = User(id: user.id, userName: user.userName, imageURL: user.imageURL)
                    userWithURLParametersSet.imageURL = userWithURLParametersSet.imageURL.replacingOccurrences(of: "{size}", with: "50")
                    return UserCellViewModel(user: userWithURLParametersSet)
                })
                self?.viewDelegate?.usersFetched()
            case .failure(let error):
                self?.viewDelegate?.errorFetchingUsers(error.localizedDescription)
            }
        }
    }
    
    func numberOfSections() -> Int {
           return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < userViewModels.count else { return }
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user)
    }

}

struct userDetailDataHelper {
    let id: Int
    let topicCount: Int
    let likesGiven: Int
    let likesRecieved: Int
    let postCount: Int
    let postsRead: Int 
}
