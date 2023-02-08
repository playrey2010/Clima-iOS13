//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
//MARK: - UIViewController
class WeatherViewController: UIViewController {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    // This object is responsible for getting hold of the current GPS location of the device
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // assign delegate to the location manager
        locationManager.delegate = self
        // we need to ask the user's for permission before though
        // and this creates the popup we all know and love
        locationManager.requestWhenInUseAuthorization()
        // Once previous function delivers, it requests location
//        locationManager.startUpdatingLocation() would be better in a real app as it's not just a one-time use
        locationManager.requestLocation()
        
        
        
        searchTextField.delegate = self // the current view controller becomes the delegate for the search field, constantly updating what is happening in the search field to the view controller
        weatherManager.delegate = self
    }
}

//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
//        print(searchTextField.text!)
    }
    
    // the below function comes from/depends on the UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
//        print(searchTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Please type a location"
            return false
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        // Use searchTextField.text to get the weather for that city
        if let city = searchTextField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
        searchTextField.text = ""
    }
}
//MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
//        print("I got triggered. You wrote \(weather.cityName)")
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

//MARK: - CoreLocationManager

extension WeatherViewController: CLLocationManagerDelegate {
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)

    }
}
