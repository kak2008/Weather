//
//  AddCityViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 10/22/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesTableView.dataSource = self
    }
    
    @IBAction func onDonePressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: TableView Datasource Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherData.sharedData.listOfCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityNameCell", for: indexPath)
        
        let city = WeatherData.sharedData.listOfCities[(indexPath as NSIndexPath).row]
        cell.textLabel?.text = city.name
        cell.detailTextLabel?.text = city.country
        
        return cell
    }
}
