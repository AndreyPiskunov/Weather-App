//
//  CityModel.swift
//  Weather
//
//  Created by Andrey Piskunov on 21.10.2022.
//

import Foundation

struct CityModel: Codable {
    let id: Int
    let state: String
    let cityName: String
    let countryID: String
    let countryName: String
}
