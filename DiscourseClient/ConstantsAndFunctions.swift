//
//  ConstantsAndFunctions.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 21/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

func setTabBarItem(_ tabBarItem: UITabBarItem){
    if let image = tabBarItem.image {
        tabBarItem.image = image.withRenderingMode(.alwaysOriginal)
    }
    if let selectedImage = tabBarItem.selectedImage {
        tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
    }
}
