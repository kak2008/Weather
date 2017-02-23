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
    //key : 9f73de1c0bf34317f0cb5c26da477c94
    let ApiKey = "9f73de1c0bf34317f0cb5c26da477c94"

    func getWeatherData(_ location: String, failure: (_ errorMessage: String) -> Void, success: @escaping () -> Void)
    {
        // URL Request creation
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=\(location)&mode=json&appid=\(ApiKey)"
        let url = URL(string: urlString)
        
        // URL Request Session
        let conf = URLSessionConfiguration.default
        
        let session = URLSession(configuration: conf)

        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
           
            // error handling
            if error != nil
            {
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
            catch let error1 as NSError
            {
                //     print("Unable to parse the response data!")
                // ToDo:- create Alert with error
            
                print(error1)
            }
        }) 
        task.resume()
    }
}
