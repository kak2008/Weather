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
    var selectedIndexPath:NSInteger! = -1
    var cellRowHeight: Double = 75
    var expansionRowHeight: Double = 142
    
    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getSavedLocationsWeatherInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Helper Methods
    /**
     Fetches current weather info/data for each saved location
     */
    func getSavedLocationsWeatherInfo() -> Void
    {
        for item in citiesList {
            let apiObj = ApiClient()
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
    
    func showAlertWithOKAction(alertTitle: String, alertMessage: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - Delegate Methods
    func addSelectedCity(selectedCity: String) {
        for item in citiesList {
            if(item == selectedCity) {
                showAlertWithOKAction(alertTitle: "Error", alertMessage: "City already exists.")
                return
            }
        }
        receivedCityName = selectedCity
        citiesList.append(receivedCityName)
        getSavedLocationsWeatherInfo()
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
        let cityObj = cities[indexPath.row] as City
        let weatherObj = cityObj.weatherList.first! as Weather
        
        // var weatherInfo = WeatherData.sharedData.weatherList
        print(weatherObj.date,weatherObj.timeStamp)
        cell.cityTimeLabel.text = "07:12 PM"
        cell.cityNamelabel.text = "\(cityObj.name), \(cityObj.country)"
        cell.cityWeatherDescriptionLabel.text = "\(weatherObj.description)"
        
        let convertedTemp = convertTempUnits(temp: weatherObj.temperature, conversionType: "\(tempUnit)")
        let tempValue = convertDecimalToString(temp: convertedTemp)
        cell.cityWeatherTempLabel.text = NSString(format: "\(tempValue)%@" as NSString, UISymbols.tempDegreeSymbol) as String
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == selectedIndexPath {
            return CGFloat(expansionRowHeight)
        } else {
            return CGFloat(cellRowHeight)
        }
    }
    

    // MARK: - Segue Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SearchLocationTableViewController
        destinationVC.selectedCityDelegate = self
    }
}
