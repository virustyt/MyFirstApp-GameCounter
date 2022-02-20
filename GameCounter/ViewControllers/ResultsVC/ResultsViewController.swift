//
//  ResultsViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 23.09.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    private let topThreeScoresView = FirstThreePlacesStackView()
    private let scoresTableViewController: ScoresTableViewController = {
        let controller = ScoresTableViewController()
        controller.tableView.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    private var allScoresTableView: UITableView {
        return scoresTableViewController.tableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        addSubviews()
        configureConstraints()
        configureNavigationItems()
    }
    
    private func configureNavigationItems(){
        let newResultsBarButtonItem = UIBarButtonItem(title: "New game", style: .plain, target: self, action: #selector(newResultsBarButtonTapped))
        let titleAtributes: [NSAttributedString.Key: Any] = [.font:UIFont.navigationBarButtonTextFont ?? UIFont(),
                                                             .foregroundColor: UIColor.navigationBarButtonTextColor]
        navigationItem.leftBarButtonItem = newResultsBarButtonItem
        navigationItem.leftBarButtonItem?.setTitleTextAttributes(titleAtributes, for: .normal)
        
        let resumeBarButtonItem = UIBarButtonItem(title: "Resume", style: .plain, target: self, action: #selector(resumeBarButtonTapped))
        navigationItem.rightBarButtonItem = resumeBarButtonItem
        navigationItem.rightBarButtonItem?.setTitleTextAttributes(titleAtributes, for: .normal)
        
        navigationItem.title = "Results"
        navigationItem.largeTitleDisplayMode = .always
        
        guard let navController = navigationController else {return}
        navController.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white,
                                                                .font: UIFont(name: "nunito-extrabold", size: 36) ?? UIFont()]
        navController.navigationBar.prefersLargeTitles = true
    }
    
    private func addSubviews(){
        view.addSubview(topThreeScoresView)
        view.addSubview(allScoresTableView)
        addChild(scoresTableViewController)
    }
    
    private func configureConstraints(){
        NSLayoutConstraint.activate([
            topThreeScoresView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            topThreeScoresView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 18),
            topThreeScoresView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18),
            
            allScoresTableView.topAnchor.constraint(equalTo: topThreeScoresView.bottomAnchor, constant: 25),
            allScoresTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            allScoresTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            allScoresTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
   
    //MARK: - selectors
    
    @objc private func newResultsBarButtonTapped(){
        guard let navController = navigationController else {return}
        print(navController.viewControllers.count)
        if navController.viewControllers.count == 3 {
            navController.popToRootViewController(animated: true)
        } else {
            navController.pushViewController(NewGameViewController(), animated: true)
        }
    }
    
    @objc private func resumeBarButtonTapped(){
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
