//
//  AddCityViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 10/22/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: AddCityTextField!
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add City"
        addRightBarButton()
        setupTextField()
    }
    
    func cancelButtonPressed() {
        self.view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Bar Button Item Methods
    func addRightBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                            target: self,
                                                            action: #selector(cancelButtonPressed))
    }

    //MARK: Text Field Methods
    func setupTextField() {
        searchTextField.clearButtonMode = UITextFieldViewMode.whileEditing
        searchTextField.returnKeyType = UIReturnKeyType.search
        
        // For future reference
        /* searchTextField.leftViewMode = UITextFieldViewMode.always
        searchTextField.leftView = UIImageView(image: UIImage(named: "AddCity-Search")) */

    }

}
