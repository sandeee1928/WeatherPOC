//
//  ViewControllerTest.swift
//  Weather
//
//  Created by SANDEEP on 6/7/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import XCTest
@testable import Weather

class ViewControllerTest: XCTestCase {
    
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        
        viewController = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        // access view to call ViewDidLoad
        _ = viewController.view
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCheckAllOutletConnected() {
        XCTAssertNotNil(viewController.activityIndicator)
        XCTAssertNotNil(viewController.messageLabel)
        XCTAssertNotNil(viewController.containerView)
        XCTAssertNotNil(viewController.locationLabel)
        XCTAssertNotNil(viewController.currentCondition)
        XCTAssertNotNil(viewController.tempratureLabel)
        XCTAssertNotNil(viewController.sunriseLabel)
        XCTAssertNotNil(viewController.sunsetLabel)
        XCTAssertNotNil(viewController.windLabel)
        XCTAssertNotNil(viewController.humidityLabel)
        XCTAssertNotNil(viewController.pressureLabel)
        XCTAssertNotNil(viewController.visibilityLabel)
    }

    func testShowAddLocationMessageIfNoLocationFound() {
        
        viewController.updateUI(selectedLocation: nil)
        XCTAssertTrue(!viewController.messageLabel.isHidden)
        XCTAssertTrue(viewController.containerView.isHidden)
    }
    
    func testActivityIndicator() {
        viewController.showActivity()
        XCTAssertTrue(viewController.activityIndicator.isAnimating)
        viewController.hideActivity()
        XCTAssertTrue(!viewController.activityIndicator.isAnimating)
    }
    
    func testUIWithWeatherInfo() {
        let weatherModelJson = WeatherHelper.getValidWeatherModelJson()
        let weatherModel = WeatherModel(json: weatherModelJson)
        let weatherViewModel = WeatherViewModel(weather: weatherModel)
        viewController.updateUIWithWeatherInfo(weather: weatherViewModel)
        
        XCTAssertTrue(weatherViewModel.name == viewController.locationLabel.text)
    
        XCTAssertTrue(weatherViewModel.condition == viewController.currentCondition.text)
    
        XCTAssertTrue(weatherViewModel.tempreture == viewController.tempratureLabel.text)
    
        XCTAssertTrue(weatherViewModel.sunrise == viewController.sunriseLabel.text)
    
        XCTAssertTrue(weatherViewModel.sunset == viewController.sunsetLabel.text)
    
        XCTAssertTrue(weatherViewModel.wind == viewController.windLabel.text)
    
        XCTAssertTrue(weatherViewModel.humidity == viewController.humidityLabel.text)
    
        XCTAssertTrue(weatherViewModel.pressure == viewController.pressureLabel.text)
    
        XCTAssertTrue(weatherViewModel.visibility == viewController.visibilityLabel.text)
        
    }
}
