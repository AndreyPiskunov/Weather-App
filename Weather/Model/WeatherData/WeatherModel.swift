//
//  WeatherModel.swift
//  Weather
//
//  Created by Andrey Piskunov on 17.10.2022.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let timezone: Int
    
    var weatherTemperature: String {
    String(format: "%.0f°", temperature)
}
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud"
        default:
            return "error"
        }
    }
}
