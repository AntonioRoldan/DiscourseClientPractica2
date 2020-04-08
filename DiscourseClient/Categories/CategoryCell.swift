//
//  CategoryCell.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 08/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class CategoryCell : UITableViewCell {
    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
        }
    }
}
