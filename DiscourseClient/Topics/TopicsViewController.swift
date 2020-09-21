//
//  TopicsViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 01/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa un listado de topics
class TopicsViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "TopicCell", bundle: nil), forCellReuseIdentifier: "TopicCell")
        table.register(UINib(nibName: "PinnedCell", bundle: nil), forCellReuseIdentifier: "PinnedCell")
        table.estimatedRowHeight = 100
        table.rowHeight = UITableView.automaticDimension
        return table
    }()
    
    lazy var addTopicButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame(forAlignmentRect: CGRect.init(x: CGFloat(0), y: CGFloat(0), width: CGFloat(64), height: CGFloat(64)))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(red: 243.0/255.0, green: 144/255.0, blue: 0, alpha: 1.0)
        button.setBackgroundImage(UIImage.init(named: "icoNew"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 32.0
        return button
    }()

    let viewModel: TopicsViewModel

    init(viewModel: TopicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = UIView()
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        self.tableView.addSubview(addTopicButton)
        NSLayoutConstraint.activate([
            addTopicButton.widthAnchor.constraint(equalToConstant: CGFloat(64)),
            addTopicButton.heightAnchor.constraint(equalToConstant: CGFloat(64)),
            addTopicButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: CGFloat(-15)),
            addTopicButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant:  CGFloat(-15))
        ])

//        let rightBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusButtonTapped))
//        rightBarButtonItem.tintColor = .black
//        navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
    }

    @objc func plusButtonTapped() {
        viewModel.plusButtonTapped()
    }

    fileprivate func showErrorFetchingTopicsAlert(_ errorMessage: String) {
        showAlert(errorMessage)
    }
}

extension TopicsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as? TopicCell,
            let cellViewModel = viewModel.viewModel(at: indexPath) as? TopicCellViewModel {
            cell.viewModel = cellViewModel
            return cell
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PinnedCell", for: indexPath) as? PinnedCell, let cellViewModel = viewModel.viewModel(at: indexPath) as? PinnedCellViewModel{
//            cell.heightAnchor.constraint(equalToConstant: 151).isActive = true

            cell.viewModel = cellViewModel
            return cell
        }
        fatalError()
    }
}

extension TopicsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didSelectRow(at: indexPath)
    }
}

extension TopicsViewController: TopicsViewDelegate {
    func topicsFetched() {
        tableView.reloadData()
        
    }

    func errorFetchingTopics(_ errorMessage: String) {
        showErrorFetchingTopicsAlert(errorMessage)
    }
}
