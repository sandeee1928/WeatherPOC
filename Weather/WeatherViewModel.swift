//
//  WeatherViewModel.swift
//  Weather
//
//  Created by SANDEEP on 6/6/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import Foundation

class WeatherViewModel {
    
    var name: String? = nil
    var condition: String? = nil
    var iconUrl: String? = nil
    var tempreture: String? = nil
    var highLowTemp: String? = nil
    var sunrise: String? = nil
    var sunset: String? = nil
    var wind: String? = nil
    var humidity: String? = nil
    var pressure: String? = nil
    var visibility: String? = nil
    
    init(weather: WeatherModel) {
    
        self.name = weather.name
        if let weathr = weather.weathers?.first {
            if let condition = weathr.main {
                self.condition = condition
            }
            if let icon = weathr.icon {
                self.iconUrl = "http://openweathermap.org/img/w/\(icon).png"
            }
        }
        
        if let tempreture = weather.main?.temp {
            self.tempreture = "\(tempreture)°F"
        }
        if let highTemp = weather.main?.tempMin, let lowTemp = weather.main?.tempMin {
            self.highLowTemp = "H: \(highTemp)°F / L: \(lowTemp)°F"
        }
        
        if let sunrise = weather.system?.sunrise {
            let date = Date(timeIntervalSince1970: TimeInterval(sunrise))
            self.sunrise = "Sunrise: \(date.dateToString())"
        }
        
        if let sunset = weather.system?.sunset {
            let date = Date(timeIntervalSince1970: TimeInterval(sunset))
            self.sunset = "Sunset: \(date.dateToString())"
        }
        
        if let wind = weather.wind?.speed {
            self.wind = "Wind: \(wind) MPH"
        }
        
        if let pressure = weather.main?.pressure {
            self.pressure = "Pressure: \(pressure) hPa"
        }
        
        if let humidity = weather.main?.humidity {
            self.humidity = "Humidity: \(humidity)%"
        }
        if let visibility = weather.visibility {
            self.visibility = "Visibility: \(visibility/1609) Miles"
        }
    }
    
    
}

extension Date {
    
    func dateToString() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self as Date)
    }
    
}
