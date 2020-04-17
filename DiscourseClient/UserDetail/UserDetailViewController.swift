//
//  UserDetailViewController.swift
//  DiscourseClient
//
//  Created by Antonio Miguel Roldan de la Rosa on 26/03/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserDetailViewController : UIViewController {
    let viewModel: UserDetailViewModel
    
    init(viewModel: UserDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Required init not implemented")
    }
    
    lazy var userIDLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userUserNameLabel : UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
    }()
    
    lazy var userNameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var userEditNameField : UITextField = {
        let textField = UITextField()
        textField.placeholder = "Edit your name here"
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
        return textField
    }()
    
    lazy var editNameButton : UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(NSLocalizedString("Edit name", comment: ""), for: .normal)
        button.backgroundColor = .cyan
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(editNameButtonTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var userIDStackView: UIStackView = {
        let labelUserIDTitle = UILabel()
        labelUserIDTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserIDTitle.text = NSLocalizedString("User ID: ", comment: "")
        labelUserIDTitle.textColor = .black

        let topicIDStackView = UIStackView(arrangedSubviews: [labelUserIDTitle, userIDLabel])
        topicIDStackView.translatesAutoresizingMaskIntoConstraints = false
        topicIDStackView.axis = .horizontal

        return topicIDStackView
    }()

    lazy var userUserNameStackView: UIStackView = {
        let labelUserUserNameTitle = UILabel()
        labelUserUserNameTitle.text = NSLocalizedString("Username: ", comment: "")
        labelUserUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserUserNameTitle.textColor = .black

        let topicNameStackView = UIStackView(arrangedSubviews: [labelUserUserNameTitle, userUserNameLabel])
        topicNameStackView.translatesAutoresizingMaskIntoConstraints = false
        topicNameStackView.axis = .horizontal

        return topicNameStackView
    }()
    
    lazy var userNameStackView: UIStackView = {
        let labelUserNameTitle = UILabel()
        labelUserNameTitle.text = NSLocalizedString("Name: ", comment: "")
        labelUserNameTitle.translatesAutoresizingMaskIntoConstraints = false
        labelUserNameTitle.textColor = .black
        
        let topicPostsCountStackView = UIStackView(arrangedSubviews: [labelUserNameTitle, userNameLabel])
        topicPostsCountStackView.translatesAutoresizingMaskIntoConstraints = false
        topicPostsCountStackView.axis = .horizontal
        
        return topicPostsCountStackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewWasLoaded()
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(userIDStackView)
        NSLayoutConstraint.activate([
            userIDStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userIDStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        view.addSubview(userUserNameStackView)
        NSLayoutConstraint.activate([
            userUserNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userUserNameStackView.topAnchor.constraint(equalTo: userIDStackView.bottomAnchor, constant: 8)
        ])
        view.addSubview(userNameStackView)
        NSLayoutConstraint.activate([
            userNameStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userNameStackView.topAnchor.constraint(equalTo: userUserNameStackView.bottomAnchor, constant: 8)
        ])
        view.addSubview(userEditNameField)
        NSLayoutConstraint.activate([
            userEditNameField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            userEditNameField.topAnchor.constraint(equalTo: userNameStackView.bottomAnchor, constant: 8)
        ])
        view.addSubview(editNameButton)
        NSLayoutConstraint.activate([
            editNameButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            editNameButton.topAnchor.constraint(equalTo: userEditNameField.bottomAnchor, constant: 16),
            editNameButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ])
    }
    
    func showAlert(message: String, title: String) {
        showAlert(message, title)
    }
    
    @objc func editNameButtonTapped(){
        guard let text = userEditNameField.text, !text.isEmpty else { return }
        viewModel.editName(newName: text)
    }
}

extension UserDetailViewController : UserDetailViewDelegate {
    /*
     Aquí podríamos haber utilizado el mismo método userFetched para actualizar toda la UI, no había necesidad de crear otro método delegate.
     De esta manera, el viewModel tendría dos propiedades editNameButtonIsHidden y userEditNameFieldIsHidden, que cambiarías desde el ViewModel
     justo antes de llamar a userFetched, y que consultarías desde el ViewController una vez el delegate es llamado.
     Ojo, no digo que esté mal, pero quedaría un cógido más consistente.
     */
    func canEditName() {
        editNameButton.isHidden = false
        userEditNameField.isHidden = false
    }
    func userFetched() {
        guard let id = viewModel.id else {fatalError("Could not load unwrap id")}
        userIDLabel.text = String(id)
        userUserNameLabel.text = viewModel.username
        userNameLabel.text = viewModel.name
    }
    func displayAlert(message: String, title: String){
        showAlert(message, title)
    }
}
