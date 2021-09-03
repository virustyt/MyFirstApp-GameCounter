//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    private var constraintTitleLeadingAnchor:NSLayoutConstraint!
 
    private lazy var viewTitle: UIStackView = {
        let title = GameProcessTitleStackView()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let timer = TimerStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureSubviews()
        configureConstraints()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    override func viewDidLayoutSubviews() {
        constraintTitleLeadingAnchor.constant = leftButton.convert(self.leftButton.frame, to: nil).minX
        view.layoutIfNeeded()
    }
    
    private func configureSubviews(){
        view.addSubview(viewTitle)
        view.addSubview(timer)
    }
    
    private func configureConstraints(){
        constraintTitleLeadingAnchor = viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        constraintTitleLeadingAnchor.isActive = true
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            timer.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 29),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configureNavigationBar(){
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftButton)
        
        navigationItem.leftBarButtonItem?.target = self
        navigationItem.leftBarButtonItem?.action = #selector(backButtonTapped)
    }
    
    @objc private func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    private lazy var leftButton: UIView = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let text = NSAttributedString(string: "New Game",
                                      attributes: [.font:UIFont.navigationBarButtonTextFont!,
                                                .foregroundColor: UIColor.navigationBarButtonTextColor])
        button.setAttributedTitle(text, for: .normal)
        button.autoresizesSubviews = true
        button.autoresizingMask = [.flexibleWidth , .flexibleHeight]
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        button.frame = view.frame
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: button.titleLabel?.frame.origin.x ?? 0.0)
        view.addSubview(button)
        
        return view
    }()
}
