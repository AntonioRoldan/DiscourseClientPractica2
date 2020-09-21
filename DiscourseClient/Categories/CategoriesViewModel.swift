//
//  CategoriesViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation

protocol CategoriesViewDelegate : class {
    func categoriesFetched()
    func errorFetchingCategories(message: String)
}

/// ViewModel representando un listado de categorías
class CategoriesViewModel {
    weak var viewDelegate : CategoriesViewDelegate?
    let dataManager : CategoriesDataManager
    var categoryViewModels : [CategoryCellViewModel] = []
    
    init(dataManager: CategoriesDataManager) {
        self.dataManager = dataManager
    }
    
    func viewWasLoaded(){
        self.dataManager.fetchCategories { [weak self] result in
            guard let self = self else {fatalError("Could not unwrap self")}
            switch result {
            case .success(let categoriesResponse):
                self.categoryViewModels = categoriesResponse.categoryList.categories.map{ category in
                    return CategoryCellViewModel(category: category)
                }
                self.viewDelegate?.categoriesFetched()
            case .failure(let error):
                self.viewDelegate?.errorFetchingCategories(message: error.localizedDescription)
            }
        }
    }
    
    func numberOfSections() -> Int {
           return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return categoryViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CategoryCellViewModel? {
        guard indexPath.row < categoryViewModels.count else { return nil }
        return categoryViewModels[indexPath.row]
    }
}
