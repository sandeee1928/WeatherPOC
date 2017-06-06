//
//  ViewController.swift
//  Weather
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentCondition: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var highLowTempLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    
    @IBOutlet weak var  activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var  containerView: UIView!
    @IBOutlet weak var  messageLabel: UILabel!
    
    var weather: WeatherViewModel!
    
    fileprivate var managedObjectContext: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedLocation = getSelectedLocation() {
            messageLabel.isHidden = true
            activityIndicator.startAnimating()
            getWeatherData(location: selectedLocation.name!);
        } else {
            messageLabel.isHidden = false
            containerView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAddLocation" {
            if let destinationVC = segue.destination as? UINavigationController {
                if let locationVC = destinationVC.viewControllers.first as? LocationTableViewController {
                    locationVC.locationDelegate = self
                }
            }
        }
    }
    
    
    
    func getWeatherData(location : String) {
        let urlDownloader = URLDownloader()
        let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(location)&units=metric&appid=100f4edbfec73d3ead46e23574e19f1b"
        urlDownloader.downLoad(urlString: urlString) { (success, result) in
            if success {
                let weatherModel = WeatherModel(json: JSON(result!))
                self.weather = WeatherViewModel(weather: weatherModel)
                OperationQueue.main.addOperation({
                    self.activityIndicator.stopAnimating()
                    self.saveLocation(weatherModel: weatherModel)
                    self.updateUI()
                })
            }
        }
    }
    

    private func updateUI() {
        
        messageLabel.isHidden = true
        containerView.isHidden = false
        
        locationLabel.text = weather.name
        currentCondition.text = self.weather.condition;
        tempratureLabel.text = self.weather.tempreture
        highLowTempLabel.text = self.weather.highLowTemp
        windLabel.text = self.weather.wind
        
        sunsetLabel.text = weather.sunset
        sunriseLabel.text = weather.sunrise
        
        humidityLabel.text = self.weather.humidity
        pressureLabel.text = weather.pressure
        visibilityLabel.text = weather.visibility
        
        let urlDownloader = URLDownloader()
        urlDownloader.downloadImage(urlString: weather.iconUrl!) { (success, image) in
            if let image = image {
                OperationQueue.main.addOperation({
                    self.iconImageView.image = image
                })
            }
        }
    }
    
    private func saveLocation(weatherModel: WeatherModel) {
    
        
        let request = NSFetchRequest<NSManagedObject>(entityName: "Location")
        do {
            let locations = try managedObjectContext.fetch(request)
            var found = false
            
            for location in locations {
                if let location = location as? Location {
                    if Int(location.cityId) == weatherModel.id! {
                        location.selected = true
                        found = true
                    } else {
                        location.selected = false
                    }
                }
            }
            
            if !found {
                let location = Location(context: managedObjectContext)
                location.name = weatherModel.name
                location.cityId = Int32(weatherModel.id!)
                location.addedOn = NSDate()
                location.selected = true
                
                do {
                    try managedObjectContext.save()
                } catch {
                    let fetchError = error as NSError
                    print("\(fetchError), \(fetchError.userInfo)")
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
    private func getSelectedLocation() -> Location? {
        let request = NSFetchRequest<NSManagedObject>(entityName: "Location")
        request.predicate = NSPredicate(format: "selected == %@", true as CVarArg)
        do {
            let locations = try managedObjectContext.fetch(request)
            return locations.first as? Location
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
    
}

extension ViewController: LocationDelegate {
    func locationSearched(name: String) {
        self.getWeatherData(location: name)
    }
}
