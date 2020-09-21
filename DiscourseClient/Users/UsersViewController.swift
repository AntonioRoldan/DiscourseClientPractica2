//
//  UsersViewController.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 20/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UsersViewController : UIViewController {
    let viewModel: UsersViewModel
    
    lazy var collectionView: UICollectionView = {
        let columns = 3
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2.0
        let itemWidth = UIScreen.main.bounds.width/3 - layout.minimumInteritemSpacing
        let itemHeight = itemWidth + 10
        layout.minimumLineSpacing = 0.0
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        collection.dataSource = self
        collection.delegate = self
        collection.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
        return collection
    }()
    
    init(viewModel: UsersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        self.navigationController?.navigationBar.prefersLargeTitles = true 
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func viewDidLoad() {
           super.viewDidLoad()
           viewModel.viewWasLoaded()
    }
    
    fileprivate func showErrorFetchingUsersAlert(_ errorMessage: String) {
        showAlert(errorMessage)
    }
    
}

extension UsersViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell {
            cell.viewModel = viewModel.viewModel(at: indexPath)
            return cell
        }
        fatalError()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.userViewModels.count
    }
}


extension UsersViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath)
    }
}

extension UsersViewController : UsersViewDelegate {
   func usersFetched() {
        collectionView.reloadData()
   }

   func errorFetchingUsers(_ errorMessage: String) {
       showErrorFetchingUsersAlert(errorMessage)
   }
}

