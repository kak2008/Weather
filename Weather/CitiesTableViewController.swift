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
        getWeatherDataCalling()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getWeatherDataCalling() -> Void
    {
        let apiObj = ApiClient()
        apiObj.getWeatherData("Michigan", failure: { (errorMessage) in
        }) {
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
            })

        }
    }

    // MARK: - Table View Methods

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cities = WeatherData.sharedData.listOfCities
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCell", for: indexPath) as! CityTableViewCell
        
        var cities = WeatherData.sharedData.listOfCities
        var weatherInfo = WeatherData.sharedData.weatherList
        
        let cityObj = cities[indexPath.row]
        let weatherObj = weatherInfo[indexPath.row]
        
        cell.cityTimeLabel.text = "07:12 PM"
        cell.cityNamelabel.text = "\(cityObj.country)"
        cell.cityWeatherDescriptionLabel.text = "\(weatherObj.description)"
        
        let convertedTemp = convertTempUnits(temp: weatherObj.temperature, conversionType: "Celsius")
        let tempValue = convertDecimalToString(temp: convertedTemp)
        cell.cityWeatherTempLabel.text = NSString(format: "\(tempValue)%@" as NSString, "\u{00b0}") as String
       
        return cell
    }
    
    func convertTempUnits(temp: Double, conversionType: String) -> Double {
        switch conversionType {
        case "Celsius": return (temp - 273.15)
        case "Fahrenheit": return ((temp - 273.15) * 9/5 ) + 32
        default: return temp
        }
    }
    
    func convertDecimalToString(temp: Double) -> String {
        let tempValue = "\(temp)"
        let splitValue = tempValue.characters.split(separator: ".")
        return String(splitValue.first!)
    }
}
