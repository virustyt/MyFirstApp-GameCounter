//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    private var constraintTitleLeadingAnchorInset:NSLayoutConstraint!
    private let timer = TimerStackView()
    private let scoreCollectionViewController = ScoreCollectionViewController.init(collectionViewLayout: ScoresCollectionViewFlowLayout())
    private var numberOfSelectedCell = 1
    
    private lazy var collectionViewContainer: UIView = {
        let container = UIView()
        container.addSubview(scoreCollectionViewController.collectionView)
        scoreCollectionViewController.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.topAnchor),
            container.leadingAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.bottomAnchor)
        ])
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    private var  distanceBetweenCellsCenters: CGFloat {
        guard let flowLayout = scoreCollectionViewController.collectionViewLayout as? UICollectionViewFlowLayout,scoreCollectionViewController.collectionView.visibleCells.count != 0 else {return 0.0}
        let distanceBetweenCellsCenters = scoreCollectionViewController.collectionView(scoreCollectionViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)).frame.size.width + flowLayout.minimumLineSpacing
        return distanceBetweenCellsCenters
    }
    
    private var collectionViewLeftInset: CGFloat {
        guard scoreCollectionViewController.collectionView.visibleCells.count != 0 else {return 0.0}
        let cellWidth = scoreCollectionViewController.collectionView(scoreCollectionViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)).frame.size.width
        let neededDistance = (collectionViewContainer.frame.size.width - cellWidth) / 2
        return neededDistance
    }
    
    private let priviousNextButtonsView: ScoreNavigationStackView = {
        let stack = ScoreNavigationStackView()
        stack.priviousButton.addTarget(self, action: #selector(priviousScoreButtonTapped), for: .touchUpInside)
        stack.plusOneButton.addTarget(self, action: #selector(plusOneButtonTapped), for: .touchUpInside)
        stack.nextButton.addTarget(self, action: #selector(nextScoreButtonTapped), for: .touchUpInside)
        return stack
    }()
    
    private lazy var viewTitle: UIStackView = {
        let title = GameProcessTitleStackView()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        addSubviews()
        configureConstraints()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        constraintTitleLeadingAnchorInset.constant = leftButton.convert(self.leftButton.frame, to: nil).minX
        
        guard let layout = scoreCollectionViewController.collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {return}
        layout.sectionInset.left = collectionViewLeftInset
    }
    
    private func addSubviews(){
        view.addSubview(viewTitle)
        view.addSubview(timer)
        self.addChild(scoreCollectionViewController)
//        view.addSubview(scoreCollectionViewController.collectionView)
        view.addSubview(collectionViewContainer)
        scoreCollectionViewController.didMove(toParent: self)
        view.addSubview(priviousNextButtonsView)
    }
    
    private func configureConstraints(){
        constraintTitleLeadingAnchorInset = viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        constraintTitleLeadingAnchorInset.isActive = true
        
        NSLayoutConstraint.activate([
            viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            timer.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 29),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            collectionViewContainer.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 42),
            collectionViewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionViewContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionViewContainer.heightAnchor.constraint(equalToConstant: 300),
            
            priviousNextButtonsView.topAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.bottomAnchor, constant: 28),
            priviousNextButtonsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 46),
            priviousNextButtonsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50)
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
    
    @objc private func nextScoreButtonTapped(){
        guard 1...GameModel.shared.allPlayers.count - 1 ~= numberOfSelectedCell else {return}
//        let nextXOffset = scoreCollectionViewController.collectionView.contentOffset.x + distanceBetweenCellsCenters
        let nextXOffset = distanceBetweenCellsCenters * CGFloat(numberOfSelectedCell)
        let nextpoint = CGPoint(x: nextXOffset, y: 0)
        scoreCollectionViewController.collectionView.setContentOffset(nextpoint, animated: true)
        numberOfSelectedCell += 1
    }
    
    @objc private func priviousScoreButtonTapped(){
        guard 2...GameModel.shared.allPlayers.count ~= numberOfSelectedCell else {return}
//        let nextXOffset = scoreCollectionViewController.collectionView.contentOffset.x - distanceBetweenCellsCenters
        let nextXOffset = distanceBetweenCellsCenters * CGFloat(numberOfSelectedCell - 2)
        let nextpoint = CGPoint(x: nextXOffset, y: 0)
        scoreCollectionViewController.collectionView.setContentOffset(nextpoint, animated: true)
        numberOfSelectedCell -= 1
    }
    
    @objc private func plusOneButtonTapped(){
        
    }
}
