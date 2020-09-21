//
//  TopicsViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

/// Delegate a través del cual nos vamos a comunicar con el coordinator, contándole todo aquello que atañe a la navegación
protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

/// Delegate a través del cual vamos a comunicar a la vista eventos que requiran pintar el UI, pasándole aquellos datos que necesita
protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics(_ errorMessage: String)
}

/// ViewModel que representa un listado de topics
class TopicsViewModel {
    weak var coordinatorDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var topicViewModels: [CellModel] = []

    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }

    func viewWasLoaded() {
        /** TODO:
         Recuperar el listado de latest topics del dataManager
         Asignar el resultado a la lista de viewModels (que representan celdas de la interfaz
         Avisar a la vista de que ya tenemos topics listos para pintar
         */
        self.fetchAllTopics()
    }
    
    func fetchAllTopics() {
        let pinnedCellViewModel = PinnedCellViewModel()
        topicViewModels.append(pinnedCellViewModel)
        self.topicsDataManager.fetchAllTopics { [weak self] (result) in
            switch result {
            case .success(let latestTopicsResponse):
                guard let topics = latestTopicsResponse.topicList?.topics else { fatalError("Could not unwrap topics")}
                let latestPosters = latestTopicsResponse.latestPosters
                self?.configureTopicCells(topics, latestPosters)
                self?.viewDelegate?.topicsFetched()
            case .failure(let sessionAPIError):
                self?.viewDelegate?.errorFetchingTopics(sessionAPIError.localizedDescription)
            }
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return topicViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> CellModel? {
        guard indexPath.row < topicViewModels.count else { return nil }
        return topicViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < topicViewModels.count else { return }
        if let topicCellViewModel = topicViewModels[indexPath.row] as? TopicCellViewModel{
            coordinatorDelegate?.didSelect(topic: topicCellViewModel.topic)
        }
    }
    
    private func configureTopicCells(_ topics: [Topic], _ latestPosters: [latestPoster]){
        for topic in topics {
            let latestPoster = latestPosters.filter {latestPoster in
                latestPoster.userName == topic.lastPosterUserName
            }
            guard let avatarLink = latestPoster.first?.avatarLink else { return }
            let linkWithParameters = avatarLink.replacingOccurrences(of: "{size}", with: "100")
            let avatarImageUrl = URL(string: apiURL + linkWithParameters)
            let topicCellViewModel = TopicCellViewModel(topic: topic, avatarImageUrl)
            topicViewModels.append(topicCellViewModel)
        }
    }
    
    func plusButtonTapped() {
        coordinatorDelegate?.topicsPlusButtonTapped()
    }
    
    func topicWasDeleted(){
        self.topicViewModels.removeAll()
        self.fetchAllTopics()
    }

    func newTopicWasCreated() {
        // TODO: Seguramente debamos recuperar de nuevo los topics del datamanager, y pintarlos de nuevo
        self.topicViewModels.removeAll()
        self.fetchAllTopics()
    }
}
