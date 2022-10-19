//
//  ViewController.swift
//  Weather
//
//  Created by Andrey Piskunov on 13.10.2022.
//

import UIKit

class CityViewController: UIViewController {
    
    @IBOutlet weak var cityTable: UITableView!
    
    var refreshControl = UIRefreshControl()//refreshing of a scroll view’s contents
    
    var weatherManager = WeatherManager()
    var cityNames = ["Moscow","Nizhny Tagil","Sochi","Ekaterinburg"] //Presaved queries
    var displayWeather:[WeatherModel] = [] // Fetched data for display in TableViews
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        cityTable.contentInset.top = 10//Space before the first cell
        
        weatherManager.delegate = self
        
        //Refresh control settings
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refreshWeatherData), for: .valueChanged)
        cityTable.addSubview(refreshControl)
        fetchWeatherData()
    }
    
    @objc func refreshWeatherData(_ sender: AnyObject){
        fetchWeatherData()
        refreshControl.endRefreshing()//Tells refresh operation has ended
    }
    
    //Helper functions
    func fetchWeatherData() {
        displayWeather.removeAll()
        
        for cityName in cityNames {
            weatherManager.fetchWeather(cityName: cityName)
            let blankWeather = WeatherModel(conditionId: 0, cityName: cityName, temperature: 0)
            
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
        
        // Populate the cell with data
        cell.cityNameLabel.text = displayWeather[indexPath.row].cityName
        cell.degreeLabel.text = displayWeather[indexPath.row].weatherTemperature
        
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

