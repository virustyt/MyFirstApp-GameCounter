//
//  AddPlayerViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import UIKit

class AddPlayerViewController: UIViewController{

    private lazy var nameTextField: UITextField = {
        let textField = AddPlayerTextField()
        textField.backgroundColor = UIColor(red: 0.231, green: 0.231, blue: 0.231, alpha: 1)
        textField.textColor = UIColor(red: 0.608, green: 0.608, blue: 0.631, alpha: 1)
        textField.font = UIFont(name: "Nunito-ExtraBold", size: 20)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.88
        textField.attributedPlaceholder = NSMutableAttributedString(string: "Player Name",
                                                                    attributes: [NSAttributedString.Key.kern: 0.15,
                                                                                 NSAttributedString.Key.paragraphStyle: paragraphStyle,
                                                                                 .foregroundColor: UIColor(red: 0.608, green: 0.608, blue: 0.631, alpha: 1)])
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.keyboardAppearance = .light
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureSubviews()
        configureLayout()
        view.backgroundColor = .black
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "Add Player"
        let barItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBarButtonHandler))
        barItem.isEnabled = false
        barItem.tintColor = UIColor.clear
        navigationItem.setRightBarButtonItems([barItem], animated: true)
    }
    
    private func configureSubviews(){
        view.addSubview(nameTextField)
    }
    
    private func configureLayout(){
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func addBarButtonHandler (){
        guard let newName = nameTextField.text,
              newName.isEmpty == false,
              !GameModel.shared.allPlayers.contains(newName)
              else {return}
        GameModel.shared.allPlayers.append(newName)
        GameModel.shared.playersScores[newName] = [0]
        navigationController?.popViewController(animated: true)
    }
}

extension AddPlayerViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldRange = NSRange(location: 0, length: textField.text?.count ?? 0)
            if NSEqualRanges(range, textFieldRange) && string.count == 0 {
                navigationItem.rightBarButtonItem?.isEnabled = false
                navigationItem.rightBarButtonItem?.tintColor = UIColor.clear
            }
            else {
                navigationItem.rightBarButtonItem?.isEnabled = true
                navigationItem.rightBarButtonItem?.tintColor = UIColor.navigationBarButtonTextColor
            }
            return true
    }
}
