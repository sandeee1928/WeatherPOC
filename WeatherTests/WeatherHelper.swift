//
//  WeatherHelper.swift
//  Weather
//
//  Created by SANDEEP on 6/7/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import XCTest

class WeatherHelper: NSObject {
    
    class func getValidCoordinateJson() -> [String: AnyObject] {
        return ["lat":22.6,
                "lon":46.3] as [String : AnyObject]
    }
    
    class func getValidWeatherJson() -> [String: AnyObject] {
        return ["id":800,
                "main":"Clear",
                "description":"clear sky",
                "icon":"44D"] as [String : AnyObject]
    }
    
    class func getValidMainJson() -> [String: AnyObject] {
        return ["temp":76,
                "pressure":234,
                "humidity":41,
                "temp_min":"70",
                "temp_max":82] as [String : AnyObject]
    }
    
    class func getValidWindJson() -> [String: AnyObject] {
        return ["speed":140.3,
                "deg":290.0,
                "gust":55.8] as [String : AnyObject]
    }
    
    class func getValidSystemJson() -> [String: AnyObject] {
        return ["type":1,
                "id":1234,
                "message":0.0036,
                "country":"US",
                "sunrise":1496916142,
                "sunset":1496969978] as [String : AnyObject]
    }
    
    class func getValidWeatherModelJson() -> [String : AnyObject] {
        return ["coord": getValidCoordinateJson(),
         "main": getValidMainJson(),
         "wind": getValidWindJson(),
         "sys": getValidSystemJson(),
         "weather": [getValidWeatherJson()],
         "id": 5176472,
         "name": "Westerville",
         "visibility": 16093] as [String : AnyObject]
    }
}
