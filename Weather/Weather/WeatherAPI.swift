//
//  WeatherAPI.swift
//  Weather
//
//  Created by 민성홍 on 2022/04/13.
//

import Foundation

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
