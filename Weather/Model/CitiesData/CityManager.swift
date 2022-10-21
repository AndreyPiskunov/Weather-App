//
//  CityManager.swift
//  Weather
//
//  Created by Andrey Piskunov on 21.10.2022.
//

import Foundation

struct CityManager {
    
    func getCityList() -> [CityModel]? {

        if let localData = self.readFile(), let cityList = self.parse(jsonData: localData) {
            return cityList
        }
        return nil
    }
    
    //Helper functions
    private func readFile() -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: "CityList", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    private func parse(jsonData: Data) -> [CityModel]? {
        
        do {
            let decodedData = try JSONDecoder().decode([CityData].self, from: jsonData)
            var cityList = [CityModel]()
            
            for city in cityList {
                let newCity = CityModel(id: city.id, state: city.state, cityName: city.countryName, countryID: city.countryID, countryName: "")
                cityList.append(newCity)
            }
            return cityList
            
        } catch {
            print("Decode error - \(error)")
        }
        return nil
    }
}
