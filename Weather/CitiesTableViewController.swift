//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 2/25/17.
//  Copyright © 2017 Anish Kodeboyina. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table View Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        cell.cityTimeLabel.text = "07:12 PM"
        cell.cityNamelabel.text = "Hyderabad"
        cell.cityWeatherDescriptionLabel.text = "Clear Sky"
        cell.cityWeatherTempLabel.text = NSString(format: "45%@", "\u{00b0}") as String
        
        return cell
    }
}
