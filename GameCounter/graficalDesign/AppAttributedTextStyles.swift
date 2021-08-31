//
//  AppTextAttributesNSAttributedStringExtension.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 30.08.2021.
//

import UIKit

let navigationBarButtonItemAttributedTextStyle: [NSAttributedString.Key: Any] = {
    var paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = 1.77
    return [NSAttributedString.Key.paragraphStyle: paragraphStyle]
}()

