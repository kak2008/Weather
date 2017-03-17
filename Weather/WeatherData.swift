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
    var zipcodeCityList = Array<ZipcodeCity>()

    
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

    func updateZipcodeCities(_ json: NSDictionary) {
        let recievedJson: [String: Any] = json as! [String : Any]
        if let results = recievedJson["results"] as? [[String: Any]] {
            
            if results.count > 0 {
                let resultsDic = results[0]
                
                if let address = resultsDic["address_components"] as? [[String: Any]] {
                    
                    for dict in address {
                        
                        if let longName = dict["long_name"] as? String,
                            //let shortName = dict["short_name"] as? String,
                            let types = dict["types"] as? [String] {
                            
                            if types.contains("postal_code") {
                                
                                print("postal_code: \(longName)")
                            } else if types.contains("locality") {
                                
                                print("city: \(longName)")
                            } else if types.contains("administrative_area_level_2") {
                                
                                print("county: \(longName)")
                            } else if types.contains("administrative_area_level_1") {
                                
                                print("state: \(longName)")
                            } else if types.contains("country") {
                                
                                print("country: \(longName)")
                            }
                        }
                    }
                }
            }
        }
        
        /* let recievedJson = json
        let results = recievedJson["results"] as! Array
        let resultsDic = results[0] as! NSDictionary
        let address = resultsDic["address_components"] as? NSArray
        let zipcodeDic = address?[0] as! NSDictionary
        let cityNameDic = address?[1] as! NSDictionary
        let countyDic = address?[2] as! NSDictionary
        let stateDic = address?[3] as! NSDictionary
        let countryDic = address?[4] as! NSDictionary
        let zipcode = zipcodeDic["long_name"] as! String
        let cityName = cityNameDic["long_name"] as! String
        let countyName = countyDic["long_name"] as! String
        let stateName = stateDic["long_name"] as! String
        let stateShortName = stateDic["short_name"] as! String
        let countryName = countryDic["long_name"] as! String
        let countryShortName = countryDic["short_name"] as! String
        print(zipcode,cityName,countyName,stateName,stateShortName,countryName,countryShortName) */
    }

}
