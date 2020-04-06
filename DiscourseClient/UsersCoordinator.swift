//
//  UsersCoordinator.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersCoordinator : Coordinator {
    //TODO: Create UserDetailViewModel along with its data manager and view controller 
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDetailDataManager: UsersDataManager

    init(presenter: UINavigationController, usersDataManager: UsersDataManager,
         userDetailDataManager: UsersDataManager) {
        self.presenter = presenter
        self.usersDataManager = usersDataManager
        self.userDetailDataManager = userDetailDataManager
    }
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: self.usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewController.title = NSLocalizedString("Users", comment: "")
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        presenter.pushViewController(usersViewController, animated: true)
    }
    
    override func finish(){}
}

extension UsersCoordinator : UsersCoordinatorDelegate {
    func didSelect(user: User) {
        
    }
}
