//
//  GameProcessVCExtension.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 21.09.2021.
//

import Foundation

extension GameProcessViewController: TimerStackViewDelegate {
    func secondsPassedDidChange(secondsPassed:Int) {
        GameModel.shared.secondsPassed = secondsPassed
    }
}
