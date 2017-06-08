//
//  URLDownloader.swift
//  Weather
//
//  Created by SANDEEP on 6/5/17.
//  Copyright © 2017 myProject. All rights reserved.
//

import Foundation
import UIKit

class URLDownloader {
    
    // set up the session
    var session: URLSession
    
    convenience init() {
        let config = URLSessionConfiguration.default
        self.init(config: config)
    }
    
    init(config: URLSessionConfiguration) {
        self.session = URLSession(configuration: config)
    }
    
    func downLoad(urlString: String, taskCallback: @escaping (Bool, AnyObject?) -> ()) {
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!)
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse , 200...299 ~= response.statusCode {
                    taskCallback(true, json as AnyObject?)
                } else {
                    taskCallback(false, json as AnyObject?)
                }
            }
        })
        task.resume()
    }
    
    func downloadImage(urlString: String, taskCallback: @escaping (Bool, UIImage?) -> ()) {
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        let downloadTask = session.downloadTask(with: request) { (url, urlResponse, error) in
            if error == nil {
                do {
                    let data = try Data(contentsOf: url!)
                    let image = UIImage(data: data)
                    taskCallback(true, image)
                } catch {
                    taskCallback(false, nil)
                }
                
            } else {
                taskCallback(false, nil)
            }
        }
        downloadTask.resume()
        
    }
}
