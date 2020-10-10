//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Young Hur on 10/5/20.
//

import Foundation

class WeatherLocation: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func getData() {
        let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&exclude=minutely&units=imperial&appid=\(APIkeys.openWeatherKey)"
        
        print("🕸 We are accessing the url \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        // Create Session
        let session = URLSession.shared
        
        // Get data with .dataTask method
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("😡 ERROR: \(error.localizedDescription)")
            }
            
            // Note: there are some additional things that could go wrong when using URLSession, but we shouldn't experience them, so we'll ignore testing for these for now...
            
            // Deal with the data
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("😎 \(json)")
            } catch {
                print("😡 JSON ERROR: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
}
