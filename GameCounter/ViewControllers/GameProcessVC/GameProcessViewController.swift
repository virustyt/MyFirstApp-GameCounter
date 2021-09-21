//
//  GameProcessViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

class GameProcessViewController: UIViewController {
    
    private var titleLeftInset:NSLayoutConstraint!
    private var titleRightInset: NSLayoutConstraint!
    private var collectionViewHeight: NSLayoutConstraint!
    private lazy var timer:TimerStackView = {
        let timer = TimerStackView(seconds: GameModel.shared.secondsPassed)
        if GameModel.shared.secondsPassed != 0 { timer.timerPaused = false }
        timer.delegate = self
        return timer
    }()
    
    private var numberOfcellInCenter:Int  {
        get{
            guard  let flowlayout = scoreCollectionViewController.collectionViewLayout as? ScoresCollectionViewFlowLayout
            else {return 0}
            return flowlayout.numberOfCellInCenter
        }
        set{
            guard  let flowlayout = scoreCollectionViewController.collectionViewLayout as? ScoresCollectionViewFlowLayout
            else {return}
            flowlayout.numberOfCellInCenter = newValue
        }
    }

    private lazy var newGameBarButtonItem: UIView = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(newGameButtonTapped), for: .touchUpInside)
        let text = NSAttributedString(string: "New Game",
                                      attributes: [.font:UIFont.navigationBarButtonTextFont!,
                                                .foregroundColor: UIColor.navigationBarButtonTextColor])
        button.setAttributedTitle(text, for: .normal)
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        button.frame = view.frame
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: button.titleLabel?.frame.origin.x ?? 0.0)
        view.addSubview(button)
        
        return view
    }()
    
    private var resultsBarButtonItem: UIView = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(resultBarButtonIemTapped), for: .touchUpInside)
        let text = NSAttributedString(string: "Results",
                                      attributes: [.font:UIFont.navigationBarButtonTextFont!,
                                                .foregroundColor: UIColor.navigationBarButtonTextColor])
        button.setAttributedTitle(text, for: .normal)
        button.titleLabel?.textAlignment = .right
        button.contentHorizontalAlignment = .right
        
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 110, height: 50))
        button.frame = view.frame
        view.addSubview(button)
        
        return view
    }()
    
    private lazy var scoreCollectionViewController: ScoreCollectionViewController = {
        let layout = ScoresCollectionViewFlowLayout()
        layout.numberOfCellInCenter = GameModel.shared.currentPlayer
        let controller = ScoreCollectionViewController.init(collectionViewLayout: layout)
        controller.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NotificationCenter.default.addObserver(self, selector: #selector(centeredCellDidChangeBySwipe), name: .centeredCellDidChange, object: nil)
        return controller
    }()
    
    private lazy var viewTitle: UIStackView = {
        let title = GameProcessTitleStackView()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let priviousNextButtonsStack: ScoreNavigationStackView = {
        let stack = ScoreNavigationStackView()
        stack.priviousButton.addTarget(self, action: #selector(priviousCellButtonTapped), for: .touchUpInside)
        stack.plusOneButton.addTarget(self, action: #selector(plusOneButtonTapped), for: .touchUpInside)
        stack.nextButton.addTarget(self, action: #selector(nextCellButtonTapped), for: .touchUpInside)
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
        stack.setWhiteColorToCharachter(index: numberOfcellInCenter)
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
        titleLeftInset.constant = newGameBarButtonItem.convert(self.newGameBarButtonItem.frame, to: nil).minX
        titleRightInset.constant = -(view.safeAreaLayoutGuide.layoutFrame.width - resultsBarButtonItem.convert(self.resultsBarButtonItem.frame, to: nil).maxX)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: .centeredCellDidChange, object: nil)
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
        titleRightInset = viewTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        collectionViewHeight = scoreCollectionViewController.collectionView.heightAnchor.constraint(equalToConstant:  view.frame.size.height / 2.7)
        
        
        NSLayoutConstraint.activate([
            titleLeftInset,
            titleRightInset,
            viewTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
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
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: newGameBarButtonItem)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: resultsBarButtonItem)
    }
    
    
    private func changeScoreOfSelectedCell(by score: Int){
        let playerName = GameModel.shared.allPlayers[numberOfcellInCenter]
        guard let playerScore = GameModel.shared.playersScores[playerName] else {return}
        GameModel.shared.playersScores[playerName] = playerScore + [score]
        scoreCollectionViewController.collectionView.reloadItems(at: [IndexPath(item: numberOfcellInCenter, section: 0)])
    }
    
    private func setNextCellToCenter(){
        if numberOfcellInCenter == GameModel.shared.allPlayers.count - 1 {
            numberOfcellInCenter = 0
        } else {
            numberOfcellInCenter += 1
        }
    }
    
    private func setPriviousCellToCenter(){
        if numberOfcellInCenter == 0 {
            numberOfcellInCenter = GameModel.shared.allPlayers.count - 1
        } else {
            numberOfcellInCenter -= 1
        }
    }
    
    //MARK: - selectors
    @objc private func newGameButtonTapped(){
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationController?.popViewController(animated: true)
        } else {
            navigationController?.pushViewController(NewGameViewController(), animated: true)
        }
    }
    
    @objc private func nextCellButtonTapped(){
        setNextCellToCenter()
    }
    
    @objc private func priviousCellButtonTapped(){
        setPriviousCellToCenter()
    }
    
    @objc private func plusOneButtonTapped(){
        changeScoreOfSelectedCell(by: +1)
        setNextCellToCenter()
    }
    
    @objc private func plusFiveButtonTapped(){
        changeScoreOfSelectedCell(by: +5)
        setNextCellToCenter()
    }
    
    @objc private func plusTenButtonTapped(){
        changeScoreOfSelectedCell(by: +10)
        setNextCellToCenter()
    }
    
    @objc private func minusOneButtonTapped(){
        changeScoreOfSelectedCell(by: -1)
        setNextCellToCenter()
    }
    
    @objc private func minusFiveButtonTapped(){
        changeScoreOfSelectedCell(by: -5)
        setNextCellToCenter()
    }
    
    @objc private func minusTenButtonTapped(){
        changeScoreOfSelectedCell(by: -10)
        setNextCellToCenter()
    }
    
    @objc private func undoButtonPressed(){
        let playerName = GameModel.shared.allPlayers[numberOfcellInCenter]
        guard let playerScore = GameModel.shared.playersScores[playerName] else {return}
        print(GameModel.shared.playersScores[playerName]!)
        GameModel.shared.playersScores[playerName] = playerScore.count > 1 ? playerScore.dropLast() : playerScore
        print(GameModel.shared.playersScores[playerName]!)
        scoreCollectionViewController.collectionView.reloadItems(at: [IndexPath(item: numberOfcellInCenter, section: 0)])
        setPriviousCellToCenter()
    }
    
    @objc private func resultBarButtonIemTapped(){
        
    }
    
    @objc private func centeredCellDidChangeBySwipe(notification: Notification) {
        undoAndMiibarStack.setWhiteColorToCharachter(index: numberOfcellInCenter)
        GameModel.shared.currentPlayer = numberOfcellInCenter
    }
}

