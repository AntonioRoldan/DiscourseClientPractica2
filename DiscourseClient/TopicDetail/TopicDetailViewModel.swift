//
//  TopicDetailViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate que usaremos para comunicar eventos relativos a navegación, al coordinator correspondiente
protocol TopicDetailCoordinatorDelegate: class {
    func topicDetailBackButtonTapped()
    func topicDetailDeleteButtonTapped()
}

/// Delegate para comunicar a la vista cosas relacionadas con UI
protocol TopicDetailViewDelegate: class {
    func topicCanBeDeleted()
    func topicDetailFetched()
    func errorFetchingTopicDetail()
}

class TopicDetailViewModel {
    var labelTopicIDText: String?
    var labelTopicNameText: String?
    var labelTopicPostsCountText: String?

    weak var viewDelegate: TopicDetailViewDelegate?
    weak var coordinatorDelegate: TopicDetailCoordinatorDelegate?
    let topicDetailDataManager: TopicDetailDataManager
    let topicID: Int
    var can_delete: Bool = false

    init(topicID: Int, topicDetailDataManager: TopicDetailDataManager) {
        self.topicID = topicID
        self.topicDetailDataManager = topicDetailDataManager
    }

    func viewDidLoad() {
        topicDetailDataManager.fetchTopic(id: self.topicID) { [weak self] (result) in
            switch result {
                case .success(let singleTopicResponse):
                    self?.labelTopicIDText = String(singleTopicResponse.id)
                    self?.labelTopicNameText = String(singleTopicResponse.title)
                    self?.labelTopicPostsCountText = String(singleTopicResponse.postsCount)
                    if singleTopicResponse.details.can_delete != nil && singleTopicResponse.details.can_delete == true{
                        self?.viewDelegate?.topicCanBeDeleted()
                    }
                    self?.viewDelegate?.topicDetailFetched()
                case .failure(let error):
                    print(error)
                    self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }
    
    func deleteButtonTapped() {
        topicDetailDataManager.deleteTopic(id: self.topicID) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.coordinatorDelegate?.topicDetailDeleteButtonTapped()
                break
            case .failure(_):
                self?.viewDelegate?.errorFetchingTopicDetail()
            }
        }
    }

    func backButtonTapped() {
        coordinatorDelegate?.topicDetailBackButtonTapped()
    }
}
