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
    var zipcodeCityList = Array<ZipcodeCity>()
    
    func updateCityData(_ json: NSDictionary) {

        var weatherList = Array<Weather>()
        
        guard let cityJson: NSDictionary = json["city"] as? NSDictionary else {
            print("City info is not available")
            return
        }
        
        guard let list: Array = json["list"] as? Array<NSDictionary> else {
            print("City's list is not available")
            return
        }
        
        
        let cityName1 = cityJson.value(forKey: "name") as! String
        let cityCountryName = cityJson.value(forKey: "country") as! String
        let id1 = cityJson.value(forKey: "id") as! Double
        print(cityName1,cityCountryName, id1)
        
        
        for item in list {            
            let weatherJsonArray = item["weather"] as! NSArray
            let weatherJson = weatherJsonArray[0] as! NSDictionary
            
            let windJson = item["wind"] as! NSDictionary
            let mainJson = item["main"] as! NSDictionary
            
            let date = item["dt_txt"] as! String
            let timeStamp = item["dt"] as! Double
            
            let icon = weatherJson["icon"] as! String
            let main = weatherJson["main"] as! String
            let description = weatherJson["description"] as! String
            
            let windSpeed = windJson["speed"] as! Float
            
            let temperature = mainJson["temp"] as! Double
            let humidity = mainJson["humidity"] as! Double
            
            let weather = Weather(date: date,
                              timeStamp: timeStamp,
                              icon: icon,
                              main: main,
                              description: description,
                              windSpeed: windSpeed,
                              temperature: temperature,
                              humidity: humidity)
            weatherList.append(weather)

        }
        
        let cityName = cityJson["name"] as! String
        
        var indexOfCity = NSNotFound
        for i in 0..<(listOfCities.count) {
            let cityItem = listOfCities[i]
            
            if cityItem.name == cityName {
                indexOfCity = i
                break
            }
        }
        
        //if let index = listOfCities.index(where: {$0.name === cityName}) {
        if indexOfCity != NSNotFound {
            listOfCities[indexOfCity].weatherList = weatherList
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
                                                
//                        var cityResult: String?
//                        var stateResult: String?
//                        var stateShortNameResult: String?
//                        var zipcodeResult: String?
//                        var countryResult: String?
//                        var countryShortNameResult: String?
//                        var countyResult: String?
                        
                        if let longName = dict["long_name"] as? String,
                            let shortName = dict["short_name"] as? String,
                            let types = dict["types"] as? [String] {
                            
                            if types.contains("postal_code") {
                                print(" ZipCode: \(longName)")
                                print(" Zipcode SN: \(shortName)")
                                //zipcodeResult = "\(longName)"
                            } else if types.contains("locality") {
                                print(" City: \(longName)")
                                print(" City SN: \(shortName)")
                                //cityResult = "\(longName)"
                            } else if types.contains("administrative_area_level_2") {
                                print(" County: \(longName)")
                                print(" County SN: \(shortName)")
                                //countyResult = "\(longName)"
                            } else if types.contains("administrative_area_level_1") {
                                print(" State: \(longName)")
                                print(" State SN: \(shortName)")
//                                stateResult = "\(longName)"
//                                stateShortNameResult = "\(shortName)"
                            } else if types.contains("country") {
                                print(" Country: \(longName)")
                                print(" Country SN: \(shortName)")

//                                countryResult = "\(longName)"
//                                countryShortNameResult = "\(shortName)"
                            }
                            
//                            if (cityResult != nil && stateResult != nil) {
//                                let zipcodeCityResultValues = ZipcodeCity(city: cityResult!,
//                                                                          state: stateResult!,
//                                                                          stateShortName: stateShortNameResult!,
//                                                                          zipcode: zipcodeResult!,
//                                                                          country: countryResult!,
//                                                                          countryShortName: countryShortNameResult!,
//                                                                          county: countyResult!)
//                                print(zipcodeCityResultValues)
//                                zipcodeCityList.append(zipcodeCityResultValues)
                           // }
                        }
                    }
                    
                }
            }
        }
    }

}
