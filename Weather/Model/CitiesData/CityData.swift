//
//  CityData.swift
//  Weather
//
//  Created by Andrey Piskunov on 21.10.2022.
//

import Foundation
//[
//    {
//        "id": 833,
//        "name": "Ḩeşār-e Sefīd",
//        "state": "",
//        "country": "IR",
//        "coord": {
//            "lon": 47.159401,
//            "lat": 34.330502
//        }
//    },
//    {
//        "id": 2960,
//        "name": "‘Ayn Ḩalāqīm",
//        "state": "",
//        "country": "SY",
//        "coord": {
//            "lon": 36.321911,
//            "lat": 34.940079
//        }
//    },


//Data struct for JSON decoding
struct CityData: Codable {
    let id: Int
    let name: String
    let state: String
    let country: String
}
