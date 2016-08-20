//
//  ViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 8/19/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Key: 9f73de1c0bf34317f0cb5c26da477c94
 
    @IBOutlet weak var userEnteredLocationTextField: UITextField!
    @IBOutlet weak var LocationLabel: UILabel!

    //  MARK:- Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    //  MARK:- Api Webservice Calling
    /** calls web api from Api Client class */
    func getWeatherDataCalling() -> Void
    {
        let apiObj = ApiClient()
        apiObj.getWeatherData(userEnteredLocationTextField.text!, failure: { (errorMessage) in
            // Failure Case
            // error handling
            // print error
        }) {
            // Success Case
            
        }
    }
    
    //  MARK:- Button Pressed Actions
    @IBAction func submitButtonPressed(sender: AnyObject)
    {
        getWeatherDataCalling()
    }

}

