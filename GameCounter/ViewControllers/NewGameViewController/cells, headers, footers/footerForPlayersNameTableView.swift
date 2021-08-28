//
//  footerForPlayersNameTableView.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 28.08.2021.
//

import UIKit

class footerForPlayersNameTableView: UITableViewHeaderFooterView {
    static let myReuseIdentifyer = String(describing: footerForPlayersNameTableView.self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        let cell = AddPlayerTableViewCell(frame: self.frame)
        contentView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        contentView.addSubview(cell)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
