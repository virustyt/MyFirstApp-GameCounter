//
//  PlayerNameTableViewCell.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import UIKit

class PlayerNameTableViewCell: UITableViewCell {

    static let reuseIdentifyer = String(describing: PlayerNameTableViewCell.self)
    
    required init?(coder: NSCoder) {
        fatalError("init?(coder: NSCoder) is impossible to execute - This project has no stiryboards.")
    }
    
    lazy var deleteButton: UIButton =
        {
            let button = UIButton()
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "icon_Delete"), for: .normal)
            button.imageView?.sizeToFit()
            return button
        }()

    lazy var playerNameLabel: UILabel =
        {
          let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = UIColor.white
            label.font = UIFont(name: "nunito-extrabold", size: 20)
            return label
        }()

    private lazy var sortIconImageView: UIImageView =
        {
          let image = UIImageView()
            image.translatesAutoresizingMaskIntoConstraints = false
            image.image = UIImage(named: "humburger")
            return image
        }()

    private lazy var stackView: UIStackView =
        {
            let stack = UIStackView()
            stack.translatesAutoresizingMaskIntoConstraints = false
            stack.axis = .horizontal
            stack.addArrangedSubview(deleteButton)
            stack.addArrangedSubview(playerNameLabel)
            stack.addArrangedSubview(sortIconImageView)
            stack.alignment = .center
            playerNameLabel.setContentHuggingPriority(UILayoutPriority(1), for: .horizontal)
            stack.distribution = .fill
            stack.spacing = 15
            return stack
        }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 19),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -21),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            sortIconImageView.heightAnchor.constraint(equalToConstant: 16),
            sortIconImageView.widthAnchor.constraint(equalToConstant: 335/18)
        ])
    }
}
