//
//  ViewController.swift
//  Weather
//
//  Created by 민성홍 on 2022/04/13.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapFetchWeatherButton(_ sender: UIButton) {
        if let cityName = self.cityNameTextField.text {
            self.getCurrentWeather(cityName: cityName)
            self.view.endEditing(true)
        }
    }

    func getCurrentWeather(cityName: String) {
        guard let url = WeatherAPI().searchWeather(cityName: cityName).url else { return }

        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            let weatherInformation = try? decoder.decode(WeatherInformation.self, from: data)
            debugPrint(weatherInformation)
        }.resume()
    }
}

struct WeatherAPI {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/weather"

    func searchWeather(cityName: String) -> URLComponents {
        var componets = URLComponents()
        componets.scheme = WeatherAPI.scheme
        componets.host = WeatherAPI.host
        componets.path = WeatherAPI.path

        componets.queryItems = [
            URLQueryItem(name: "q", value: cityName),
            URLQueryItem(name: "appid", value: "e9693fbb57b4c713af0ddbc534913a86")
        ]

        return componets
    }
}
