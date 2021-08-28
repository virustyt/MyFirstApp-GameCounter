//
//  AddPlayerViewController.swift
//  GameCounter
//
//  Created by Vladimir Oleinikov on 27.08.2021.
//

import UIKit

class AddPlayerViewController: UIViewController {

    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        textField.placeholder = "Player Name"
        textField.becomeFirstResponder()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationItem()
        
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
        ])

    }
    
    private func configureNavigationItem() {
        let barItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonHandler))
        navigationItem.rightBarButtonItem? = barItem
    }
    
    @objc private func addBarButtonHandler (){
        
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
