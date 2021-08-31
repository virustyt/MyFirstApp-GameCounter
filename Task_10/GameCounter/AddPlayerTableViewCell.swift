//
//  AddPlayerTableViewCell.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageView?.image = UIImage(named: "Add")
        textLabel?.text = "Add player"
    }
    
    required init?(coder: NSCoder) {
        fatalError("No Storyboard Bro")
    }
}
