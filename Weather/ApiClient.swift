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

    func getWeatherData(location: String, failure: (errorMessage: String) -> Void, success: () -> Void)
    {
        // URL Request creation
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?q=London,us&mode=json&appid=9f73de1c0bf34317f0cb5c26da477c94"
        let url = NSURL(string: urlString)
        
        // URL Request Session
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        let session = NSURLSession(configuration: conf)

        let task = session.dataTaskWithURL(url!) { (data, response, error) in
           
            // error handling
            if error != nil
            {
                print(error)
                // ToDo:- create Alert with error
                return
            }
            
            
            do {
                // Data conversion: NSData to Json
                let receivedData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                print(receivedData)
                success()
            }
            catch let error1 as NSError
            {
                //     print("Unable to parse the response data!")
                // ToDo:- create Alert with error
            
                print(error1)
            }
        }
        task.resume()
    }
}
