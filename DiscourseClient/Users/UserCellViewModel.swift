//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var avatarImageUrlString: String?
    
    init(user: User) {
        self.user = user
        textLabelText = self.user.userName
        avatarImageUrlString = apiURL + self.user.imageURL
    }
}
