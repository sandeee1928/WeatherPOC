//
//  WeatherModel.swift
//  Weather
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import Foundation

struct Coordinate {
    let lat: Double?
    let lon: Double?
    
    init(json: [String: AnyObject]?) {
        self.lat = json?["lat"] as? Double
        self.lon = json?["lon"] as? Double
    }
}

struct Weather {
    let id: Int?
    let main: String?
    let description: String?
    let icon: String?
    
    init(json: [String: AnyObject]?) {
        self.id = json?["id"] as? Int
        self.main = json?["main"] as? String
        self.description = json?["description"] as? String
        self.icon = json?["icon"] as? String
    }
}

struct Main {
    let temp: Int?
    let pressure: Int?
    let humidity: Int?
    let tempMin: Int?
    let tempMax: Int?
    
    init(json: [String: AnyObject]!) {
        self.temp = json?["temp"] as? Int
        self.pressure = json?["pressure"] as? Int
        self.humidity = json?["humidity"] as? Int
        self.tempMin = json?["temp_min"] as? Int
        self.tempMax = json?["temp_max"] as? Int
    }
}

struct Wind {
    let speed: Double?
    let deg: Double?
    let gust: Double?
    
    init(json: [String: AnyObject]?) {
        self.speed = json?["speed"] as? Double
        self.deg = json?["deg"] as? Double
        self.gust = json?["gust"] as? Double
    }
}

struct System {
    let type: Int?
    let id: Int?
    let message: Double?
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
    init(json: [String: AnyObject]?) {
        self.type = json?["type"] as? Int
        self.id = json?["id"] as? Int
        self.message = json?["message"] as? Double
        self.country = json?["country"] as? String
        self.sunrise = json?["sunrise"] as? Int
        self.sunset = json?["sunset"] as? Int
        
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
    
    init(json: [String: AnyObject]) {
        self.coordinate = Coordinate(json: json["coord"] as? [String : AnyObject])
        self.base = json["base"]?.string
        self.main = Main(json: json["main"] as! [String : AnyObject])
        self.visibility = Int((json["visibility"]?.int64Value)!)
        self.wind = Wind(json: json["wind"] as? [String : AnyObject])
        self.system = System(json: json["sys"] as? [String : AnyObject])
        
        self.id = json["id"] as? Int
        self.name = json["name"] as? String
        self.cod = json["cod"] as? Int //Int((json["cod"]?.int64Value)!)
        
        var weathers = [Weather]()
        
        for json in json["weather"] as! [[String:AnyObject]] {
            weathers.append(Weather(json: json))
        }
        self.weathers = weathers
    }
}

