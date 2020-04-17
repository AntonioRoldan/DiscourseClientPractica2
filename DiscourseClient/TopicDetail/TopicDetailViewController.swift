//
//  TopicDetailViewController.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// ViewController que representa el detalle de un Topic
class TopicDetailViewController: UIViewController {

    lazy var labelTopicID: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var labelTopicTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelTopicPostsCount: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Delete", comment: ""), for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()

    lazy var topicIDStackView: UIStackView = {
        let labelTopicIDTitle = UILabel()
        labelTopicIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicIDTitle.text = NSLocalizedString("Topic ID: ", comment: "")
        labelTopicIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelTopicIDTitle, labelTopicID])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var topicNameStackView: UIStackView = {
        let labelTopicTitleTitle = UILabel()
        labelTopicTitleTitle.text = NSLocalizedString("Topic name: ", comment: "")
        labelTopicTitleTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicTitleTitle.textColor = .black

        let topicNameStackView = UIStackView(arrangedSubviews: [labelTopicTitleTitle, labelTopicTitle])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()
    
    lazy var topicPostsCountStackView: UIStackView = {
        let labelTopicPostsCountTitle = UILabel()
        labelTopicPostsCountTitle.text = NSLocalizedString("Posts count: ", comment: "")
        labelTopicPostsCountTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTopicPostsCountTitle.textColor = .black
        
        let topicPostsCountStackView = UIStackView(arrangedSubviews: [labelTopicPostsCountTitle, labelTopicPostsCount])
        topicPostsCountStackView.translatesAutoresizingMaskIntoConstraints = false
        topicPostsCountStackView.axis = .horizontal
        
        return topicPostsCountStackView
    }()

    let viewModel: TopicDetailViewModel

    init(viewModel: TopicDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func loadView() {
        view = UIView()
        view.backgroundColor = .white

        view.addSubview(topicIDStackView)
        NSLayoutConstraint.activate([
            topicIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        view.addSubview(topicNameStackView)
        NSLayoutConstraint.activate([
            topicNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicNameStackView.topAnchor.constraint(equalTo: topicIDStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(topicPostsCountStackView)
        NSLayoutConstraint.activate([
            topicPostsCountStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            topicPostsCountStackView.topAnchor.constraint(equalTo: topicNameStackView.bottomAnchor, constant: 8)
        ])
        
        view.addSubview(deleteButton)
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: topicPostsCountStackView.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])

        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func backButtonTapped() {
        viewModel.backButtonTapped()
    }
    
    @objc func deleteButtonTapped() {
        viewModel.deleteButtonTapped()
    }

    fileprivate func showErrorFetchingTopicDetailAlert() {
        let alertMessage: String = NSLocalizedString("Error fetching topic detail\nPlease try again later", comment: "")
        showAlert(alertMessage)
    }

    fileprivate func updateUI() {
        labelTopicID.text = viewModel.labelTopicIDText
        labelTopicTitle.text = viewModel.labelTopicNameText
        labelTopicPostsCount.text = viewModel.labelTopicPostsCountText
    }
}

extension TopicDetailViewController: TopicDetailViewDelegate {
    func topicDetailFetched() {
        updateUI()
    }

    /*
     Te comento lo mismo que te decía en el módulo de UserDetail,
     Aquí podríamos haber utilizado el mismo método topicDetailFetched para actualizar toda la UI, no había necesidad de crear otro método delegate.
     De esta manera, el viewModel tendría una propiedad más, deleteButtonIsHidden, que cambiarías desde el ViewModel
     justo antes de llamar a topicDetailFetched, y que consultarías desde el ViewController una vez el delegate es llamado.
     Ojo, no digo que esté mal, pero quedaría un cógido más consistente.
     */
    
    func topicCanBeDeleted(){
        deleteButton.isHidden = false
    }

    func errorFetchingTopicDetail() {
        showErrorFetchingTopicDetailAlert()
    }
}
