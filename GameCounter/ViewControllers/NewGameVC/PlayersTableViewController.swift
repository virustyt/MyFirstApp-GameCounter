//
//  PlayersTableViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 26.08.2021.
//

import UIKit

class PlayersTableViewController: UITableViewController {
    
    enum Identifiers:String {
        case cell
        case header
        case footer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 59.0
        
        tableView.register(PlayerNameTableViewCell.self, forCellReuseIdentifier: Identifiers.cell.rawValue)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: Identifiers.header.rawValue)
        tableView.register(footerForPlayersNameTableView.self, forHeaderFooterViewReuseIdentifier: Identifiers.footer.rawValue)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell2")
        
        tableView.layer.cornerRadius = 15
        tableView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        tableView.isEditing = true
        tableView.separatorColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameModel.shared.playersScores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let playerName = GameModel.shared.allPlayers[indexPath.item]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cell.rawValue, for: indexPath) as? PlayerNameTableViewCell
        else { fatalError("Cell with identifyer \(Identifiers.cell.rawValue) does noy exist.") }
        let universalView = getUniversalView(view: cell as UIView)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.88
        universalView.playerNameLabel.attributedText = NSMutableAttributedString(string: playerName,
                                                                                 attributes: [NSAttributedString.Key.kern: 0.15,
                                                                                              NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                                              .font: UIFont(name: "Nunito-ExtraBold", size: 20) ?? UIFont()])
        
        universalView.leftButton.layer.setValue(playerName, forKey: "playerName")
        universalView.leftButton.addTarget(self, action: #selector(deleteButtomTapped), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.header.rawValue)
        else { fatalError("Header with udentifyer \(Identifiers.header.rawValue) does noy exist.") }
        
        header.textLabel?.text = "Players"
        header.textLabel?.font = UIFont(name: "nunito-extrabold", size: 16)
        header.textLabel?.textColor = UIColor(red: 0.922, green: 0.922, blue: 0.961, alpha: 0.6)
        header.contentView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifiers.footer.rawValue)
        else { fatalError("Header with udentifyer \(Identifiers.footer.rawValue) does noy exist.") }
        
        let universalView = getUniversalView(view: footer as UIView)
        universalView.leftButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
        universalView.addGestureRecognizer(tapGestureRecognizer)
        
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 54 }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 43 }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 54 }
    
    
    //MARK: - Editing of the table view.
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { .none }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let player = GameModel.shared.allPlayers.remove(at: indexPath.item)
            GameModel.shared.playersScores[player] = nil
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //MARK: - Rearranging the table view.
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool { true }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard  sourceIndexPath != destinationIndexPath else { return }
        GameModel.shared.allPlayers.swapAt(sourceIndexPath.item, destinationIndexPath.item)
        tableView.reloadData()
    }

    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == GameModel.shared.allPlayers.count
        {
            guard let tableViewControllerParentController = parent else {return}
            tableViewControllerParentController.navigationController?.pushViewController(AddPlayerViewController(), animated: true)
        }
    }
    
    private func getUniversalView(view: UIView) -> UniversalView {
        let universalSubviewArray = view.subviews.filter{ $0 is UniversalView}
        if universalSubviewArray.count != 0 {
            return universalSubviewArray[0] as! UniversalView
        }
        else {fatalError("View has no UniversalView in subviews.")}
    }
    
    @objc private func deleteButtomTapped(sender: UIButton){
        guard let playerName = sender.layer.value(forKey: "playerName") as? String,
              let indexOfPlayerName = GameModel.shared.allPlayers.firstIndex(of: playerName)
        else {return}
        GameModel.shared.allPlayers.remove(at: indexOfPlayerName)
        GameModel.shared.playersScores[playerName] = nil
        tableView.deleteRows(at: [IndexPath(item: indexOfPlayerName, section: 0)], with: .automatic)
    }
    
    @objc private func addButtonTapped(){
        guard let tableViewControllerParentController = parent else {return}
        tableViewControllerParentController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        tableViewControllerParentController.navigationItem.backBarButtonItem?.tintColor = UIColor.navigationBarButtonTextColor
        tableViewControllerParentController.navigationController?.pushViewController(AddPlayerViewController(), animated: true)
    }
}
