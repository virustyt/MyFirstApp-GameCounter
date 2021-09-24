//
//  ScoresTableViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 24.09.2021.
//

import UIKit

class ScoresTableViewController: UITableViewController {

    private enum cellNames: String{
        case playersData
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(PlayersDataCell.self, forCellReuseIdentifier: cellNames.playersData.rawValue)
        tableView.backgroundColor = UIColor.cellBackgroundColor
        tableView.separatorColor = UIColor.tableViewSeparatorColor
        tableView.layer.cornerRadius = 15
        tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { GameModel.shared.allPlayers.count }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNames.playersData.rawValue, for: indexPath)
        let textAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "nunito-extrabold", size: 20),
                                                            .foregroundColor: UIColor.white]
        let playerName = GameModel.shared.allPlayers[indexPath.item]
        let playersScore = GameModel.shared.playersScores[playerName]?.last ?? 0
        cell.textLabel?.attributedText = NSAttributedString(string: playerName, attributes: textAtributes)
        cell.detailTextLabel?.attributedText = NSAttributedString(string: "\(playersScore)", attributes: textAtributes)
        cell.backgroundColor = UIColor.cellBackgroundColor
        
        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UITableViewHeaderFooterView()
        let textAtributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "nanuto-semibold", size: 16) ?? UIFont(),
                                                            .foregroundColor: UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6),
                                                            .kern: 0.15]
        header.textLabel?.attributedText = NSAttributedString(string: "Turns", attributes: textAtributes)
        header.contentView.backgroundColor = UIColor.cellBackgroundColor
        return header
    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let footer = UITableViewHeaderFooterView()
//        footer.contentView.backgroundColor = UIColor.cellBackgroundColor
//        return footer
//    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 35 }
}
