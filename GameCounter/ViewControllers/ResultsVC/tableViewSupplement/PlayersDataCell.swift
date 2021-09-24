//
//  PlayersDataCell.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 24.09.2021.
//

import UIKit

class PlayersDataCell: UITableViewCell {

    private lazy var separator: UIImageView = {
        let separator = UIImageView()
        separator.backgroundColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        
        guard let mainLabel = textLabel else {return}
        
        contentView.addSubview(separator)
        
        mainLabel.leadingAnchor.constraint(equalTo: separator.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: separator.trailingAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 2).isActive = true
        separator.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
