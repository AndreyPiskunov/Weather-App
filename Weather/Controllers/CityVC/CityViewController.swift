//
//  ViewController.swift
//  Weather
//
//  Created by Andrey Piskunov on 13.10.2022.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityTable: UITableView!
    @IBOutlet weak var currentDateLabel: UILabel!
    
    var refreshControl = UIRefreshControl()//refreshing of a scroll view’s contents
    var weatherManager = WeatherManager()
    var cityNames = ["Moscow","Nizhny Tagil","Sochi","Ekaterinburg"] //Presaved queries
    var displayWeather:[WeatherModel] = [] // Fetched data for display in TableViews
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Settings for current date label
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE dd MMMM"
        let result = dateFormatter.string(from: currentDate)
        currentDateLabel.text = result
        
        //Space before the first cell
        cityTable.contentInset.top = 10
        
        weatherManager.delegate = self
        
        //Refresh control settings
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshWeatherData), for: .valueChanged)
        cityTable.addSubview(refreshControl)
        fetchWeatherData()
    }
    
    //Refresh tableview
    @objc func refreshWeatherData(_ sender: AnyObject){
        fetchWeatherData()
        refreshControl.endRefreshing()//Tells refresh operation has ended
    }
    
    //Helper functions
    func fetchWeatherData() {
        displayWeather.removeAll()
        
        for cityName in cityNames {
            weatherManager.fetchWeather(cityName: cityName)
            let blankWeather = WeatherModel(conditionId: 0, cityName: cityName, temperature: 0, timezone: 0)
            
            displayWeather.append(blankWeather)
        }
    }
}

extension CityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityTableViewCell
        
        let weatherDataForCell = displayWeather[indexPath.row]
        
        
        // Populate the cell with data
        cell.cityNameLabel.text = weatherDataForCell.cityName
        cell.degreeLabel.text = weatherDataForCell.weatherTemperature
        
        //Settings for current time label
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(secondsFromGMT: weatherDataForCell.timezone)
        dateFormatter.dateFormat = "HH:mm"
        cell.cityTimeLabel.text = dateFormatter.string(from: date)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showCityDetailVC", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CityViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            
            //Find weather index and refresh its data
            for (i,cityName) in self.cityNames.enumerated() {
                if cityName == weather.cityName {
                    self.displayWeather[i] = weather
                }
            }
            self.cityTable.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        fatalError("Failed with - \(error)")
    }
}
