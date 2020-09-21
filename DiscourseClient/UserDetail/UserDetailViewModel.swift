//
//  UserDetailViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol UserDetailCoordinatorDelegate : class {
    func didSelect(user: User)
}

protocol UserDetailViewDelegate : class {
    func canEditName()
    func userFetched()
    func displayAlert(message: String, title: String)
}

class UserDetailViewModel {
    weak var coordinatorDelegate : UserDetailCoordinatorDelegate?
    weak var viewDelegate : UserDetailViewDelegate?
    var id : Int?
    let username : String
    var name : String?
    var canEditName : Bool?
    let dataManager: UserDetailDataManager
    init(username: String, id: Int, userDetailDataManager: UserDetailDataManager) {
           self.username = username
           self.id = id 
           self.dataManager = userDetailDataManager
    }
    func viewWasLoaded(){
        fetchData()
    }
    func fetchData(){
        dataManager.fetchDetail(username: self.username) { [weak self] result in
            guard let self = self else {fatalError("Could not unwrap self")}
            switch result {
            case .success(let userDetailResponse):
                self.id = userDetailResponse.user.id
                self.name = userDetailResponse.user.name
                self.canEditName = userDetailResponse.user.canEditName
                guard let canEditName = self.canEditName else {fatalError("Cannot unwrap can edit name")}
                if canEditName {
                    self.viewDelegate?.canEditName()
                }
                self.viewDelegate?.userFetched()
            case .failure(let error):
                self.viewDelegate?.displayAlert(message: error.localizedDescription, title: "There was an error fetching the data")
            }
        }
    }
    func editName(newName: String){
        dataManager.updateName(username: self.username, name: newName) { [weak self] result in
            guard let self = self else {fatalError("Could not unwrap self")}
            switch result {
            case .success(_):
                self.viewDelegate?.displayAlert(message: "Your new name is \(newName)", title: "Your name was edited")
                self.fetchData()
            case .failure(let error):
                self.viewDelegate?.displayAlert(message: error.localizedDescription, title: "There was an error editing your name")
            }
        }
    }
}
