//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    
    @IBOutlet weak var topicTitle: UILabel!
    
    @IBOutlet weak var postsNumberLabel: UILabel!
    
    @IBOutlet weak var postersNumberLabel: UILabel!
    
    @IBOutlet weak var lastPostedAtLabel: UILabel!
    
    var viewModel: TopicCellViewModel? {
        didSet {
            self.configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.topicTitle.text = nil
        self.avatarImage.image = nil
        self.postsNumberLabel.text = nil
        self.postersNumberLabel.text = nil
        self.lastPostedAtLabel.text = nil
    }
    
    private func configureCell(){
        guard let viewModel = viewModel, let postsCount = viewModel.postsCount, let postersNumber = viewModel.postersCount, let lastPostedDate = viewModel.lastPostedAt else { return }
        viewModel.delegate = self
        self.topicTitle.text = viewModel.topicTitle
        self.postsNumberLabel.text = String(postsCount)
        self.postersNumberLabel.text = String(postersNumber)
        self.lastPostedAtLabel.text = lastPostedDate
        self.avatarImage.image = viewModel.avatarImage
    }
}

extension TopicCell : TopicCellViewModelDelegate {
    func imageFetched() {
        self.avatarImage.image = self.viewModel?.avatarImage
        setNeedsLayout()
        self.avatarImage.alpha = 0.0
        UIView.animate(withDuration: 0.24) { [weak self] in
            self?.avatarImage.alpha = 1.0
        }
    }
}
