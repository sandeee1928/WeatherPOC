//
//  WeatherViewModelTests.swift
//  WeatherViewModelTests
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherViewModelTests: XCTestCase {
    
    var weatherViewModel: WeatherViewModel!
    
    override func setUp() {
        super.setUp()
        let weatherModelJson = WeatherHelper.getValidWeatherModelJson()
        let weatherModel = WeatherModel(json: weatherModelJson)
        weatherViewModel = WeatherViewModel(weather: weatherModel)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testName() {
        XCTAssertTrue(weatherViewModel.name == "Westerville")
    }
    
    func testCondition() {
        XCTAssertTrue(weatherViewModel.condition == "Clear")
    }
    
    func testIconUrl() {
        XCTAssertTrue(weatherViewModel.iconUrl == "http://openweathermap.org/img/w/44D.png")
    }
    
    func testTempreture() {
        XCTAssertTrue(weatherViewModel.tempreture == "76°F")
    }
    
    func testHhighLowTemp() {
        XCTAssertNil(weatherViewModel.highLowTemp)
    }
    
    func testSunrise() {
        XCTAssertTrue(weatherViewModel.sunrise == "Sunrise: 6:02 AM")
    }
    func testSunset() {
        XCTAssertTrue(weatherViewModel.sunset == "Sunset: 8:59 PM")
    }
    
    func testWind() {
        XCTAssertTrue(weatherViewModel.wind == "Wind: 140.3 MPH")
    }
    
    func testHumidity() {
        XCTAssertTrue(weatherViewModel.humidity == "Humidity: 41%")
    }
    
    func testPressure() {
        XCTAssertTrue(weatherViewModel.pressure == "Pressure: 234 hPa")
    }
    
    func testVisibility() {
        XCTAssertTrue(weatherViewModel.visibility == "Visibility: 10 Miles")
    }
    
}
