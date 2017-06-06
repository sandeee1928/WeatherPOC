//
//  WeatherModel.swift
//  Weather
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Coordinate {
    let lat: Double?
    let lon: Double?
    
    init(json: JSON) {
        self.lat = json["lat"].double
        self.lon = json["lon"].double
    }
}

struct Weather {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.main = json["main"].string
        self.description = json["description"].string
        self.icon = json["icon"].string
    }
}

struct Main {
    let temp: Int?
    let pressure: Int?
    let humidity: Int?
    let tempMin: Int?
    let tempMax: Int?
    
    init(json: JSON) {
        self.temp = json["temp"].int
        self.pressure = json["pressure"].int
        self.humidity = json["humidity"].int
        self.tempMin = json["temp_min"].int
        self.tempMax = json["temp_max"].int
    }
}

struct Wind {
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
    init(json: JSON) {
        self.speed = json["speed"].double
        self.deg = json["deg"].int
        self.gust = json["gust"].double
    }
}

struct System {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
    init(json: JSON) {
        self.type = json["type"].int
        self.id = json["id"].int
        self.message = json["message"].double
        self.country = json["message"].string
        self.sunrise = json["sunrise"].int
        self.sunset = json["sunset"].int
    }
}


struct WeatherModel {
    let coordinate: Coordinate?
    let weathers: [Weather]?
    let base: String?
    let main: Main?
    let visibility: Int?
    let wind: Wind?
    let system: System?
    let id: Int?
    let name: String?
    let cod: Int?
    
    init(json: JSON) {
        self.coordinate = Coordinate(json: json["coord"])
        self.base = json["base"].string
        self.main = Main(json: json["main"])
        self.visibility = json["visibility"].int
        self.wind = Wind(json: json["wind"])
        self.system = System(json: json["sys"])
        
        self.id = json["id"].int
        self.name = json["name"].string
        self.cod = json["cod"].int
        
        var weathers = [Weather]()
        
        for json in json["weather"].arrayValue {
            weathers.append(Weather(json: json))
        }
        self.weathers = weathers
    }
}

