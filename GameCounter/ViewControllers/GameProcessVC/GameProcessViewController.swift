//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    private var titleLeftInset:NSLayoutConstraint!
    private var collectionViewHeight: NSLayoutConstraint!
    private let timer = TimerStackView()
    private let scoreCollectionViewController: ScoreCollectionViewController = {
        let controller = ScoreCollectionViewController.init(collectionViewLayout: ScoresCollectionViewFlowLayout())
        controller.collectionView.translatesAutoresizingMaskIntoConstraints = false
        return controller
    }()
    
    private(set) var numberOfSelectedCell = 0
    
    private lazy var viewTitle: UIStackView = {
        let title = GameProcessTitleStackView()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
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
    
    private let priviousNextButtonsStack: ScoreNavigationStackView = {
        let stack = ScoreNavigationStackView()
        stack.priviousButton.addTarget(self, action: #selector(priviousScoreButtonTapped), for: .touchUpInside)
        stack.plusOneButton.addTarget(self, action: #selector(plusOneButtonTapped), for: .touchUpInside)
        stack.nextButton.addTarget(self, action: #selector(nextScoreButtonTapped), for: .touchUpInside)
        return stack
    }()
    
    private lazy var changeScoreButtonsStack: ChangeScoreButtonsStackView = {
        let buttonsStack = ChangeScoreButtonsStackView()
        buttonsStack.plusFiveButton.addTarget(self, action: #selector(plusFiveButtonTapped), for: .touchUpInside)
        buttonsStack.plusTenButton.addTarget(self, action: #selector(plusTenButtonTapped), for: .touchUpInside)
        buttonsStack.minusOneButton.addTarget(self, action: #selector(minusOneButtonTapped), for: .touchUpInside)
        buttonsStack.minusFiveButton.addTarget(self, action: #selector(minusFiveButtonTapped), for: .touchUpInside)
        buttonsStack.minusTenButton.addTarget(self, action: #selector(minusTenButtonTapped), for: .touchUpInside)
        return buttonsStack
    }()
    
    private lazy var undoAndMiibarStack: UndoAndMinibarStack = {
        let stack = UndoAndMinibarStack()
        stack.undoButton.addTarget(self, action: #selector(undoButtonPressed), for: .touchUpInside)
        return stack
    }()
    
    private var  distanceBetweenCellsCenters: CGFloat {
        guard let flowLayout = scoreCollectionViewController.collectionViewLayout as? UICollectionViewFlowLayout,scoreCollectionViewController.collectionView.visibleCells.count != 0 else {return 0.0}
        let distanceBetweenCellsCenters = scoreCollectionViewController.collectionView(scoreCollectionViewController.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)).frame.size.width + flowLayout.minimumLineSpacing
        return distanceBetweenCellsCenters
    }
    
    
    //MARK: - life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
        addSubviews()
        configureConstraints()
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        titleLeftInset.constant = leftButton.convert(self.leftButton.frame, to: nil).minX

    }
    
    //MARK: - private functions
    private func addSubviews(){
        view.addSubview(viewTitle)
        view.addSubview(timer)
        self.addChild(scoreCollectionViewController)
        view.addSubview(scoreCollectionViewController.collectionView)
        scoreCollectionViewController.didMove(toParent: self)
        view.addSubview(priviousNextButtonsStack)
        view.addSubview(changeScoreButtonsStack)
        view.addSubview(undoAndMiibarStack)
    }
    
    private func configureConstraints(){
        titleLeftInset = viewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        collectionViewHeight = scoreCollectionViewController.collectionView.heightAnchor.constraint(equalToConstant:  view.frame.size.height / 2.7)
        
        
        NSLayoutConstraint.activate([
            titleLeftInset,
            viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            timer.topAnchor.constraint(equalTo: viewTitle.bottomAnchor, constant: 29),
            timer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scoreCollectionViewController.collectionView.topAnchor.constraint(equalTo: timer.bottomAnchor, constant: 42),
            scoreCollectionViewController.collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scoreCollectionViewController.collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            priviousNextButtonsStack.topAnchor.constraint(equalTo: scoreCollectionViewController.collectionView.bottomAnchor, constant: 28),
            priviousNextButtonsStack.leadingAnchor.constraint(equalTo: changeScoreButtonsStack.leadingAnchor),
            priviousNextButtonsStack.trailingAnchor.constraint(equalTo: changeScoreButtonsStack.trailingAnchor),
            
            changeScoreButtonsStack.topAnchor.constraint(equalTo: priviousNextButtonsStack.bottomAnchor, constant: 22),
            changeScoreButtonsStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            undoAndMiibarStack.topAnchor.constraint(equalTo: changeScoreButtonsStack.bottomAnchor, constant: 20),
            undoAndMiibarStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 40),
            undoAndMiibarStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            undoAndMiibarStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
    
    private func setCollectionViewLeftInset(){
        guard let layout = scoreCollectionViewController.collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
              let cellWidth = layout.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))?.frame.size.width,
              cellWidth != 0.0  else {return}
        let leftInset = (collectionViewContainer.frame.size.width - cellWidth) / 2
        layout.sectionInset.left = leftInset
    }
    
    private func changeScoreOfSelectedCell(by score: Int){
        let playerName = GameModel.shared.allPlayers[numberOfSelectedCell]
        guard let playerScore = GameModel.shared.playersScores[playerName] else {return}
        GameModel.shared.playersScores[playerName] = playerScore + score
        scoreCollectionViewController.collectionView.reloadItems(at: [IndexPath(item: numberOfSelectedCell, section: 0)])
    }
    
    func setOffsetForCell(by index: Int){
        let nextXOffset = distanceBetweenCellsCenters * CGFloat(numberOfSelectedCell + 1)
        let nextpoint = CGPoint(x: nextXOffset, y: 0)
        scoreCollectionViewController.collectionView.setContentOffset(nextpoint, animated: true)
    }
    
    //MARK: - selectors
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
        guard 0...GameModel.shared.allPlayers.count - 2 ~= numberOfSelectedCell else {return}
        scoreCollectionViewController.setOffsetForSelectedCell(withIndex: numberOfSelectedCell + 1)
        numberOfSelectedCell += 1
        undoAndMiibarStack.setWhiteColorToCharachter(index: numberOfSelectedCell)
    }
    
    @objc private func priviousScoreButtonTapped(){
        guard 1...GameModel.shared.allPlayers.count - 1 ~= numberOfSelectedCell else {return}
        scoreCollectionViewController.setOffsetForSelectedCell(withIndex: numberOfSelectedCell)
        numberOfSelectedCell -= 1
        undoAndMiibarStack.setWhiteColorToCharachter(index: numberOfSelectedCell)
    }
    
    @objc private func plusOneButtonTapped(){
        changeScoreOfSelectedCell(by: +1)
    }
    
    @objc private func plusFiveButtonTapped(){
        changeScoreOfSelectedCell(by: +5)
    }
    
    @objc private func plusTenButtonTapped(){
        changeScoreOfSelectedCell(by: +10)
    }
    
    @objc private func minusOneButtonTapped(){
        changeScoreOfSelectedCell(by: -1)
    }
    
    @objc private func minusFiveButtonTapped(){
        changeScoreOfSelectedCell(by: -5)
    }
    
    @objc private func minusTenButtonTapped(){
        changeScoreOfSelectedCell(by: -10)
    }
    
    @objc private func undoButtonPressed(){
        
    }
}
