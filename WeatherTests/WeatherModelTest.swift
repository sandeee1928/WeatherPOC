//
//  WeatherModelTest.swift
//  Weather
//
//  Created by SANDEEP on 6/7/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testCoordinateNotNil() {
        let json = WeatherHelper.getValidCoordinateJson()
        let coordinate = Coordinate(json: json)
        XCTAssertNotNil(coordinate.lat)
        XCTAssertNotNil(coordinate.lon)
        
    }
    
    func testCoordinateNil() {
        let json = ["lat1":"22",
                    "lon1":"44"]
        let coordinate = Coordinate(json: json as [String : AnyObject])
        XCTAssertNil(coordinate.lat)
        XCTAssertNil(coordinate.lon)
    }
    
    func testCoordinate() {
        let json = WeatherHelper.getValidCoordinateJson()
        let coordinate = Coordinate(json: json)
        XCTAssertTrue(coordinate.lat == 22.6)
        XCTAssertNotNil(coordinate.lon == 46.3)
    }
    
    
    
    func testWeatherNotNil() {
        let json = WeatherHelper.getValidWeatherJson()
        let weather = Weather(json: json)
        XCTAssertNotNil(weather.id)
        XCTAssertNotNil(weather.main)
        XCTAssertNotNil(weather.description)
        XCTAssertNotNil(weather.icon)
    }
    
    func testWeatherNil() {
        let json = ["id":"800"] as [String : AnyObject]
        let weather = Weather(json: json)
        XCTAssertNil(weather.id)
        XCTAssertNil(weather.main)
        XCTAssertNil(weather.description)
        XCTAssertNil(weather.icon)
    }
    
    func testWeather() {
        let json = WeatherHelper.getValidWeatherJson()
        let weather = Weather(json: json)
        XCTAssertTrue(weather.id == 800)
        XCTAssertTrue(weather.main == "Clear")
        XCTAssertTrue(weather.description == "clear sky")
        XCTAssertTrue(weather.icon == "44D")
    }
    

    func testMain() {
        let main = Main(json: WeatherHelper.getValidMainJson())
        XCTAssertTrue(main.temp == 76)
        XCTAssertTrue(main.pressure == 234)
        XCTAssertTrue(main.humidity == 41)
        XCTAssertNil(main.tempMin)
        XCTAssertTrue(main.tempMax == 82)
    }
    

    
    func testWind() {
        let wind = Wind(json: WeatherHelper.getValidWindJson())
        XCTAssertTrue(wind.speed == 140.3)
        XCTAssertTrue(wind.deg == 290.0)
        XCTAssertTrue(wind.gust == 55.8)
    }
    
    func testWindNil() {
        let wind = Wind(json: ["speed":"33"] as [String: AnyObject])
        XCTAssertNil(wind.speed)
        XCTAssertNil(wind.deg)
        XCTAssertNil(wind.gust)
    }
    
    
    func testSystem() {
        let system = System(json: WeatherHelper.getValidSystemJson())
        XCTAssertTrue(system.type == 1)
        XCTAssertTrue(system.id == 1234)
        XCTAssertTrue(system.message == 0.0036)
        XCTAssertTrue(system.country == "US")
        XCTAssertTrue(system.sunrise == 1496916142)
        XCTAssertTrue(system.sunset == 1496969978)
    }
    
    func testWeatherModel() {
        let weatherModelJson = WeatherHelper.getValidWeatherModelJson()
        let weatherModel = WeatherModel(json: weatherModelJson)
        
        XCTAssertTrue(weatherModel.id == 5176472)
        XCTAssertTrue(weatherModel.name == "Westerville")
        XCTAssertNotNil(weatherModel.coordinate)
        XCTAssertNil(weatherModel.base)
        XCTAssertNotNil(weatherModel.wind)
        XCTAssertTrue(weatherModel.system?.country == "US")
        XCTAssertTrue(weatherModel.system?.sunset == 1496969978)
        
    }
    
}
