//
//  ApiClient.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 8/19/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import UIKit

class ApiClient: NSObject
{
    func getWeatherData(_ location: String, failure: (_ errorMessage: String) -> Void, success: @escaping () -> Void)
    {
        // URL Request creation
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(location)&mode=json&appid=\(APIKeys.weatherAPIKey)"
        let url = URL(string: urlString)
        
        // URL Request Session
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
           
            // error handling
            if error != nil {
                print(error as Any)
                // ToDo:- create Alert with error
                return
            }
            
            do {
                // Data conversion: NSData to Json
                let receivedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                
                WeatherData.sharedData.updateCityData(receivedData)
                success()
            }
            catch let error1 as NSError {
                //     print("Unable to parse the response data!")
                // ToDo:- create Alert with error
            
                print(error1)
            }
        }) 
        task.resume()
    }

    func getCityWithZipcode(zipcode: String, failure: (_ errorMessage: String) -> Void, success: @escaping() -> Void) {
        // URL Request creation
        let urlString = "http://maps.googleapis.com/maps/api/geocode/json?address=\(zipcode)&sensor=true"
        let url = URL(string: urlString)
        
        // URL Request Session
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            // error handling
            if error != nil {
                print(error as Any)
                return
            }
            do {
                let receivedData = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
                WeatherData.sharedData.updateZipcodeCities(receivedData)
                success()
            }
            catch let error as NSError {
                print(error)
            }
        })
        task.resume()
    }
}
