//
//  WeatherModel.swift
//  Weather
//
//  Created by Andrey Piskunov on 17.10.2022.
//

import Foundation

//Data struct for JSON decoding
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}
