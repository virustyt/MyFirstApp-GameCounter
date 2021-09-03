//
//  TimerStackView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 31.08.2021.
//

import UIKit

class TimerStackView: UIStackView {

    private var secondsPassed = 0
    private var timerPaused = true
    private var timer = Timer()
    private var timerNumbersAttributes = [NSAttributedString.Key: Any]()
        
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.07
        timerNumbersAttributes = [.font : UIFont(name: "Nunito-ExtraBold", size: 28) ?? UIFont(),
                                                             .paragraphStyle : paragraphStyle ,
                                                             .foregroundColor : UIColor.timerColor]
        label.attributedText = NSAttributedString(string: "00:00", attributes: timerNumbersAttributes)
        return label
    }()
    
    private lazy var pauseResumeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.addTarget(self, action: #selector(timerButtonPressed), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addArrangedSubview(timeLabel)
        addArrangedSubview(pauseResumeButton)
        alignment = .center
        distribution = .fill
        spacing = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func pauseTimer() {
        timer.invalidate()
        pauseResumeButton.setImage(UIImage(named: "play"), for: .normal)
    }
    
    private func resumeTimer (){
        timer.tolerance = 0.1
        timer = Timer(timeInterval: 1, repeats: true) { [weak self] timer in
            self!.secondsPassed += 1
            let minutets = (self!.secondsPassed / 60) % 60
            let seconds = self!.secondsPassed % 60
            let stringSeconds = seconds < 10 ? "0\(seconds)" : "\(seconds)"
            let stringMinutes = minutets < 10 ? "0\(minutets)" : "\(minutets)"
            self!.timeLabel.attributedText = NSAttributedString(string: "\(stringSeconds):\(stringMinutes)", attributes: self!.timerNumbersAttributes)
        }
        RunLoop.current.add(timer, forMode: .common)
        pauseResumeButton.setImage(UIImage(named: "pause"), for: .normal)
    }
    
    @objc private func timerButtonPressed(){
        timerPaused.toggle()
        if timerPaused == true { pauseTimer() }
        else { resumeTimer() }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
