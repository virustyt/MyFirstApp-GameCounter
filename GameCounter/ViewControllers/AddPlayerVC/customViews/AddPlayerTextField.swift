//
//  AddPlayerTextField.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 29.08.2021.
//

import UIKit

class AddPlayerTextField: UITextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        let inset = UIEdgeInsets(top: 0, left: bounds.width / 16, bottom: 0, right: bounds.width / 3.75)
        return rect.inset(by: inset)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        let inset = UIEdgeInsets(top: 0, left: bounds.width / 16, bottom: 0, right: bounds.width / 3.75)
        return rect.inset(by: inset)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.clearButtonRect(forBounds: bounds)
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right:  -bounds.width / 3.75 / 2)
        return rect.inset(by: inset)
    }
    
}
