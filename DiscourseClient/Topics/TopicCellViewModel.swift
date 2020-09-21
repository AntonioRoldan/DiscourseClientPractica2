//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewModel que representa un topic en la lista
class TopicCellViewModel : CellModel {
    let topic: Topic
    var topicTitle: String?
    var postsCount: Int?
    var postersCount: Int?
    var lastPostedAt: String?
    var avatarImage: UIImage?
    var lastPoster: String?
    var avatarURL: URL?
    weak var delegate: TopicCellViewModelDelegate?
    
    init(topic: Topic, _ avatarURL: URL? = nil) {
        self.topic = topic
        super.init()
        self.avatarURL = avatarURL
        configure()
    }
    
    private func configure() {
        self.topicTitle = self.topic.title
        self.postsCount = self.topic.postsCount
        self.lastPostedAt = self.topic.lastPostedAt
        self.postersCount = self.topic.posters.count
        let dateFormatter = DateFormatter()
        let inputFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outputFormat = "MMM d"
        dateFormatter.dateFormat = inputFormat
        guard let inputDate = dateFormatter.date(from: topic.lastPostedAt) else { return }
        dateFormatter.dateFormat = outputFormat
        self.lastPostedAt = dateFormatter.string(from: inputDate)
        downloadImage()
    }
    
    func downloadImage() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard  let URL = self.avatarURL, let data = try? Data(contentsOf: URL) else { return }
            DispatchQueue.main.async {
                [weak self] in
                self?.avatarImage = UIImage(data: data)
                self?.delegate?.imageFetched()
            }
        }
    }
}

protocol TopicCellViewModelDelegate : class {
    func imageFetched()
}
