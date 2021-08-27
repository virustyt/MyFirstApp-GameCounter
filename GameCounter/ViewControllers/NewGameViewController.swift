//
//  ViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

class NewGameViewController: UIViewController {
    
    private lazy var playerTableViewController: PlayersTableViewController = {
            let tableController = PlayersTableViewController()
            tableController.tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableController
        }()
    
    private lazy var StartGameButton: UIButton = {
            let button = UIButton()
            button.setTitle("Start Game", for: .normal)
            button.titleLabel?.font = UIFont(name: "nunito-extrabold", size: 24)
            button.backgroundColor = UIColor(red: 132.0/255, green: 184.0/255, blue: 173.0/255, alpha: 1)
            button.layer.cornerRadius = 30
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOffset = CGSize(width: 0, height: 5)
            button.layer.shadowRadius = 6
            button.layer.shadowOpacity = 1
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        configureNavigationBar()
        
        view.addSubview(StartGameButton)
        view.addSubview(playerTableViewController.tableView)
        self.addChild(playerTableViewController)
        
        let heightOfTableView = traitCollection.horizontalSizeClass == .compact ? (270/812)*UIScreen.main.bounds.height : (270/812)*UIScreen.main.bounds.width
        
        NSLayoutConstraint.activate([
            playerTableViewController.tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            playerTableViewController.tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            playerTableViewController.tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            playerTableViewController.tableView.heightAnchor.constraint(equalToConstant: heightOfTableView),
            
            StartGameButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65),
            StartGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            StartGameButton.widthAnchor.constraint(equalToConstant: 335),
            StartGameButton.heightAnchor.constraint(equalToConstant: 65),

            StartGameButton.topAnchor.constraint(greaterThanOrEqualTo: playerTableViewController.tableView.bottomAnchor, constant: 20)
        ])
    }
    
    @objc private func cancelBarButtonItemHandler () {
        
    }
    
    private func configureNavigationBar(){
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "Game Counter"
        
        let cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelBarButtonItemHandler))
        navigationItem.leftBarButtonItem = cancelBarButtonItem
        navigationItem.leftBarButtonItem?.isEnabled = false
        navigationItem.leftBarButtonItem?.tintColor = UIColor.clear
    }
}

