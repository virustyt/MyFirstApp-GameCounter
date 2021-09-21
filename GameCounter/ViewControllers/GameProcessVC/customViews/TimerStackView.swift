//
//  TimerStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 31.08.2021.
//

import UIKit

protocol TimerStackViewDelegate{
    func secondsPassedDidChange(secondsPassed:Int)
}

class TimerStackView: UIStackView {

    var secondsPassed:Int! {
        didSet{
            delegate?.secondsPassedDidChange(secondsPassed: secondsPassed)
        }
    }
    var delegate: TimerStackViewDelegate?
    var timerPaused = true {
        didSet{
            if timerPaused == true { pauseTimer() }
            else { resumeTimer() }
        }
    }
    private var timer = Timer()
    private var timerNumbersAttributes = [NSAttributedString.Key: Any]()
    private let timerFont = UIFont(name: "nunito-extrabold", size: UIScreen.main.bounds.size.width / 13.4) ?? UIFont()
        
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        timerNumbersAttributes = [.font : timerFont,
                                  .paragraphStyle : paragraphStyle ,
                                  .foregroundColor : UIColor.timerColor]
        label.attributedText = stringForTimer(seconds: secondsPassed, atributes: timerNumbersAttributes)
        return label
    }()
    
    private lazy var pauseResumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.addTarget(self, action: #selector(timerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    init(seconds: Int){
        super.init(frame: .zero)
        secondsPassed = seconds
        if seconds != 0 { timerPaused = false }
        addArrangedSubview(timeLabel)
        addArrangedSubview(pauseResumeButton)
        alignment = .center
        distribution = .fill
        spacing = 20
        translatesAutoresizingMaskIntoConstraints = false
        
        pauseResumeButton.heightAnchor.constraint(equalTo: pauseResumeButton.widthAnchor).isActive = true
        pauseResumeButton.heightAnchor.constraint(equalToConstant: timerFont.capHeight).isActive = true
    }
    
    private func pauseTimer() {
        timer.invalidate()
        pauseResumeButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func resumeTimer (){
        timer.tolerance = 0.1
        timer = Timer(timeInterval: 1, repeats: true) { [weak self] timer in
            self!.secondsPassed += 1
            self!.timeLabel.attributedText = self!.stringForTimer(seconds: self!.secondsPassed, atributes: self!.timerNumbersAttributes)
        }
        RunLoop.current.add(timer, forMode: .common)
        pauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    @objc private func timerButtonPressed(){
        timerPaused.toggle()
//        if timerPaused == true { pauseTimer() }
//        else { resumeTimer() }
    }

    private func stringForTimer(seconds: Int, atributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let minutets = (seconds / 60) % 60
        let seconds = seconds % 60
        let stringSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
        let stringMinutes = minutets < 10 ? "0\(minutets)" : "\(minutets)"
        return NSAttributedString(string: "\(stringSeconds):\(stringMinutes)", attributes: atributes)
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

