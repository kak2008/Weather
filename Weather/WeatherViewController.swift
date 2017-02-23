//
//  ViewController.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 8/19/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // Key: 9f73de1c0bf34317f0cb5c26da477c94
    
    @IBOutlet weak var weatherCollectionView: UICollectionView!

    //  MARK:- Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherCollectionView.dataSource = self
        weatherCollectionView.delegate = self
        
        getWeatherDataCalling()
    }

    //  MARK:- Api Webservice Calling
    /** calls web api from Api Client class */
    func getWeatherDataCalling() -> Void
    {
        let apiObj = ApiClient()
        apiObj.getWeatherData("Hyderabad", failure: { (errorMessage) in
            // Failure Case
            // error handling
            // print error
        }) {
            // Success Case
            
            DispatchQueue.main.async(execute: { 
                self.weatherCollectionView.reloadData()
            })
            
            //TODO: Update with the below statement
//            DispatchQueue.main.async {
//                self.weatherCollectionView.reloadData()
//            }
            
        }
    }
    
    //  MARK:- Button Pressed Actions
    @IBAction func submitButtonPressed(_ sender: AnyObject)
    {
        getWeatherDataCalling()
    }

    // MARK: UICollection View Datasource Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return WeatherData.sharedData.listOfCities.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let city = WeatherData.sharedData.listOfCities[(indexPath as NSIndexPath).item];

        let cell: WeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        
        cell.cityLabel.text = city.name
        cell.weatherDescriptionLabel.text = city.weatherList[0].description
        
        return cell
    }
    
    // MARK: UICollection View Flow Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

