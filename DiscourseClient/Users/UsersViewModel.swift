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
                /*
                 Muy bien el uso de map 😍
                 */
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
    
    func downloadProfilePictures(indexPath: IndexPath, cell: UserCell){
        /*
         Aunque no está mal hacerlo así, ten en cuenta que estamos repitiendo la descarga cada vez que cellForRowAtIndexPath es llamado.
         Como alternativa propondría poner este código en el init de UserCellViewModel, así sólo lo descargamos una vez 😉

         Además, cambiar propiedades de la celda directamente desdel el ViewModel contenedor de CellViewModels traspasa los límites de MVVM,
         que dice que no debemos llamar a código UIKit desde los ViewModels.

         Muy bien por el uso de la global queue y el main.async para gesionar la descarga y posterior actualización 👏
         */
        let cellViewModel = userViewModels[indexPath.row]
        DispatchQueue.global(qos: .userInitiated).async {
            guard let urlString = cellViewModel.avatarImageUrlString, let avatarImageUrl = URL(string: urlString), let data = try? Data(contentsOf: avatarImageUrl) else { return }
            let image = UIImage(data: data)
            DispatchQueue.main.async {
                cell.imageView?.image = image
                cell.viewModel = cellViewModel
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
