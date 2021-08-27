//
//  PlayersTableViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    enum Cells:String {
        case playerCell
    }
    
    enum HeadaersAndFooters:String {
        case playersHeader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 59.0
        tableView.register(PlayerNameTableViewCell.self, forCellReuseIdentifier: PlayerNameTableViewCell.reuseIdentifyer)
        tableView.register(AddPlayerTableViewCell.self, forCellReuseIdentifier: AddPlayerTableViewCell.reuseIdentifyer)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeadaersAndFooters.playersHeader.rawValue)
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        tableView.isEditing = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameModel.shared.playersScores.count + 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0..<GameModel.shared.playersScores.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PlayerNameTableViewCell.reuseIdentifyer, for: indexPath)
                    as? PlayerNameTableViewCell else { fatalError("Cell with identifyer \(PlayerNameTableViewCell.reuseIdentifyer) does noy exist.") }
            
            cell.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            cell.playerNameLabel.text = GameModel.shared.allPlayers[indexPath.item]
            return cell
        case GameModel.shared.playersScores.count:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddPlayerTableViewCell.reuseIdentifyer, for: indexPath) as? AddPlayerTableViewCell
            else { fatalError("Cell with identifyer \(AddPlayerTableViewCell.reuseIdentifyer) does noy exist.") }
            
            return cell
        default:
            fatalError("Cell for such indexPath does noy exist.")
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeadaersAndFooters.playersHeader.rawValue)
        else { fatalError("Header with udentifyer \(HeadaersAndFooters.playersHeader.rawValue) does noy exist.") }
        
        header.textLabel?.text = "Players"
        header.textLabel?.font = UIFont(name: "nunito-extrabold", size: 16)
        header.textLabel?.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        header.contentView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        43
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    //MARK: - Editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        switch indexPath.item {
        case 0..<GameModel.shared.playersScores.count:
            return true
        case GameModel.shared.playersScores.count:
            return false
        default:
            return false
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let player = GameModel.shared.allPlayers.remove(at: indexPath.item)
            GameModel.shared.playersScores[player] = nil
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: - Rearranging the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        let indexOfAddButton = GameModel.shared.allPlayers.count
        return indexPath.item == indexOfAddButton ? false : true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        GameModel.shared.allPlayers.swapAt(sourceIndexPath.item, destinationIndexPath.item)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
