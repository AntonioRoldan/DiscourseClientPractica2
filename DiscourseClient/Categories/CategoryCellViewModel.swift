//
//  CategoryCellViewModel.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 08/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

class CategoryCellViewModel {
    let category : Category 
    var textLabelText: String?
    
    init(category: Category) {
        self.category = category
        textLabelText = self.category.name
    }
}
