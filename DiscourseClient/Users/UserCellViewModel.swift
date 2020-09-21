//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var avatarImageUrlString: String?
    var avatarImage: UIImage?
    weak var delegate: UserCellViewModelDelegate?
    init(user: User) {
        self.user = user
        textLabelText = self.user.userName
        avatarImageUrlString = apiURL + self.user.imageURL
        self.downloadImage()
    }
    func downloadImage(){
        DispatchQueue.global(qos: .userInitiated).async {
            guard let urlString = self.avatarImageUrlString, let avatarImageUrl = URL(string: urlString), let data = try? Data(contentsOf: avatarImageUrl) else { return }
            guard let image = UIImage(data: data) else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.avatarImage = image
                    self?.delegate?.imageFetched()
                }
        }
    }
}

protocol UserCellViewModelDelegate : class {
    func imageFetched()
}
