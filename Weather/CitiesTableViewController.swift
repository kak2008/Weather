//
//  CitiesTableViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 2/25/17.
//  Copyright © 2017 Anish Kodeboyina. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController, SelectedCityDelegate {

    // MARK: - Properties
    var tempUnit: String = TempUnits.Celsius
    var citiesList: Array = ["Hyderabad","Reston","Mumbai","Toronto","katmandu"]
    var receivedCityName: String!
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getWeatherDataCalling()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    func getWeatherDataCalling() -> Void
    {
        for item in citiesList {
            let apiObj = ApiClient()
            print(item)
            apiObj.getWeatherData("\(item)", failure: { (errorMessage) in
            }) {
                DispatchQueue.main.async(execute: {
                    self.reloadTableView()
                })
            }
        }
    }
    
    func convertTempUnits(temp: Double, conversionType: String) -> Double {
        switch conversionType {
        case TempUnits.Celsius: return (temp - 273.15)
        case TempUnits.Fahrenheit: return ((temp - 273.15) * 9/5 ) + 32
        default: return temp
        }
    }
    
    func convertDecimalToString(temp: Double) -> String {
        let tempValue = "\(temp)"
        let splitValue = tempValue.characters.split(separator: ".")
        return String(splitValue.first!)
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    // MARK: - Delegate Methods
    func addSelectedCity(selectedCity: String) {
        receivedCityName = selectedCity
        citiesList.append(receivedCityName)
        getWeatherDataCalling()
    }

    
    // MARK: - IBActions
    @IBAction func tempConversionButtonPressed(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tempUnit = TempUnits.Celsius
        }
        else {
            tempUnit = TempUnits.Fahrenheit
        }
        reloadTableView()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.cityTableViewCell, for: indexPath) as! CityTableViewCell
        
        var cities = WeatherData.sharedData.listOfCities
        var weatherInfo = WeatherData.sharedData.weatherList
        
        let cityObj = cities[indexPath.row]
        let weatherObj = weatherInfo[indexPath.row]
        
        cell.cityTimeLabel.text = "07:12 PM"
        cell.cityNamelabel.text = "\(citiesList[indexPath.row]), \(cityObj.country)"
        cell.cityWeatherDescriptionLabel.text = "\(weatherObj.description)"
        
        let convertedTemp = convertTempUnits(temp: weatherObj.temperature, conversionType: "\(tempUnit)")
        let tempValue = convertDecimalToString(temp: convertedTemp)
        cell.cityWeatherTempLabel.text = NSString(format: "\(tempValue)%@" as NSString, UISymbols.tempDegreeSymbol) as String
       
        return cell
    }

    // MARK: - Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SearchLocationTableViewController
        destinationVC.selectedCityDelegate = self
    }
}
