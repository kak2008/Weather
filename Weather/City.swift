//
//  City.swift
//  Weather
//
//  Created by Vasanth Kodeboyina on 10/22/16.
//  Copyright © 2016 Anish Kodeboyina. All rights reserved.
//

import Foundation

struct City {
    let id: Int
    let name: String
    let country: String
    var weatherList: Array<Weather>
}

struct Weather {
    let date: String
    let icon: String
    let main: String
    let description: String
    let windSpeed: Float
    let temperature: Double
    let humidity: Double
}

struct ZipcodeCity {
    let city: String
    let state: String
    let zipcode: Double
    let country: String
}
