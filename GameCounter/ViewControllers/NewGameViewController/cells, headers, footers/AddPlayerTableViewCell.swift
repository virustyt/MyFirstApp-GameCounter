//
//  AddPlayerTableViewCell.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import UIKit

class AddPlayerTableViewCell: UITableViewCell {

    static let reuseIdentifyer = String(describing: self)
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) is impossible to execute - This project has no stiryboards.")
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        
        imageView?.image = UIImage(named: "Add")
        let gesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        imageView?.addGestureRecognizer(gesture)
        textLabel?.textColor = UIColor(red: 0.518, green: 0.722, blue: 0.678, alpha: 1)
        textLabel?.font = UIFont(name: "nunito-extrabold", size: 16)
        textLabel?.text = "Add player"
    }
    
    @objc private  func addButtonTapped(){
        
    }
}
