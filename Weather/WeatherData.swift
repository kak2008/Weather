//
//  WeatherData.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 10/22/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import Foundation

class WeatherData: NSObject {
    static let sharedData = WeatherData()
    var listOfCities = Array<City>()
    var weatherList = Array<Weather>()

    
    func updateCityData(_ json: NSDictionary) {
        
        guard let cityJson: NSDictionary = json["city"] as? NSDictionary else {
            print("City info is not available")
            return
        }
        
        guard let list: Array = json["list"] as? Array<NSDictionary> else {
            print("City's list is not available")
            return
        }
        
        
        for item in list {
            //let weatherDetails = (item["weather"]! as! NSArray)
            
            let weatherJsonArray = item["weather"] as! NSArray
            let weatherJson = weatherJsonArray[0] as! NSDictionary
            
            let windJson = item["wind"] as! NSDictionary
            let mainJson = item["main"] as! NSDictionary
            
            let date = item["dt_txt"] as! String
            
            let icon = weatherJson["icon"] as! String
            let main = weatherJson["main"] as! String
            let description = weatherJson["description"] as! String
            
            let windSpeed = windJson["speed"] as! Float
            
            let temperature = mainJson["temp"] as! Double
            let humidity = mainJson["humidity"] as! Double
            
            let weather = Weather(date: date, icon: icon, main: main, description: description, windSpeed: windSpeed, temperature: temperature, humidity: humidity)
            
            weatherList.append(weather)
        }
        
        let cityName = cityJson["name"] as! String
        
        if let index = listOfCities.index(where: {$0.name == cityName}) {
            listOfCities[index].weatherList = weatherList
        }
        else {
            let id = cityJson["id"] as! Int
            let country = cityJson["country"] as! String
            
            let city = City(id: id, name: cityName, country: country, weatherList: weatherList)
            listOfCities.append(city)
        }
    }
}
