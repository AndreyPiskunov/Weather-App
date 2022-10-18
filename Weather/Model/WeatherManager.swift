//
//  WeatherManager.swift
//  Weather
//
//  Created by Andrey Piskunov on 17.10.2022.
//

import Foundation

protocol WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?"
    var city = ""
    let appid = "7f14b64a7f074098209cf6b9fa75e0e6"
    var units = "metric"
    
    var delegate: WeatherManagerDelegate?
    
    //MARK: - Fetching weather data
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)q=\(cityName)&appid=\(appid)&units=\(units)"
        performRequest(with: urlString)
    }
    //MARK: - Networking
    func performRequest(with urlString: String) {
        
        //Getting rid of any spaces in the URL string
        let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        if let url = URL(string: encodedURLString) {
            
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                
                //In case of error
                guard (error == nil) else {
                    delegate?.didFailWithError(error: error!) //let the delegate handle the error
                    return
                }
                
                //Handling result
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        delegate?.didUpdateWeather(self, weather: weather) //Let the delegate refresh data tables
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON (_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder() //Create decoder
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            //Decode data to conform WeatherData properties
            
            let weather = WeatherModel(conditionId: decodedData.weather[0].id,
                                       cityName: decodedData.name,
                                       temperature: decodedData.main.temp)
                //Create weather object
            
            return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
