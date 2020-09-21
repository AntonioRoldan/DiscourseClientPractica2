//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 21/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell : UICollectionViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView! {
        didSet {
            self.avatarImage.layer.cornerRadius = 40
        }
    }
    
    @IBOutlet weak var username: UILabel!
    
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            username.text = viewModel.textLabelText
            viewModel.delegate = self
            avatarImage.image = viewModel.avatarImage        }
    }
    
    override func prepareForReuse() {
        username.text = nil
        avatarImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(_ image: UIImage){
        avatarImage.image = image
    }
}

extension UserCell : UserCellViewModelDelegate {
    func imageFetched() {
        self.avatarImage.image = viewModel?.avatarImage
        setNeedsLayout()
        self.avatarImage.alpha = 0.0
        UIView.animate(withDuration: 0.24) { [weak self] in
            self?.avatarImage.alpha = 1.0
        }
    }
}
