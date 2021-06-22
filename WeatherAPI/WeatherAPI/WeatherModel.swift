//
//  WeatherModel.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//

import Foundation


struct WeatherModel: Codable {
    
    let weather: [Weather]
    let base: String
    let main: Main?
    let visibility: Int
    let sys: Sys
    let name: String
    
}

struct Main: Codable {
    let temp, feelsLike, tempMin: Double?
    let tempMax, humidity: Double?
   

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
       
    }
}


struct Sys: Codable {
    let country: String
}


struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}


