//
//  WeatherService.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//

import Foundation
class WeatherService {


func fetchWeatherData(city:String, completionHandler : @escaping (WeatherModel)->Void )  {


            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=a51a075fe97539350b7ea0972ed37d36&units=metric")!
                    
                   // Create (define) a task; remember that we are just defining it
                   // After the multi-line statement executes, "task" exists,
                   // but it is in a "suspended" state
                   
                   // The task requires a callback parameter, which is a Swift closure
                   // When the task completes, it will call the closure (function),
                   // and pass some arguments; all three are optional; see the docs...
                   // https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask
                   
      
                    
    
                   let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                       
                       if let error = error {
                        
                           print("error in url session")
                           print(error)
                           return
                       }
                       
                       // We want to ensure that we have a good HTTP response status
                       guard let httpResponse = response as? HTTPURLResponse,
                           (200...299).contains(httpResponse.statusCode)
                           else {
                               // Show the URL and response status code in the debug console
                               if let httpResponse = response as? HTTPURLResponse {
                                   print("URL: \(httpResponse.url!.path )\nStatus code from Amrinder: \(httpResponse.statusCode)")
                               }
                               return
                       }
                       
                      
                           if let data = data {
                           
                           // Create and configure a JSON decoder
                           let decoder = JSONDecoder()
                           decoder.dateDecodingStrategy = .iso8601
                    
                           do {
                            
                               let result = try decoder.decode(WeatherModel.self, from: data)
                               
                               
                            print("result in url session")
                            print(result)
                           
                               
                            completionHandler(result)
                               
                           }
                           catch {
                                print("error exception in url session")
                            print(error)
                           }
                       }
                   }
                   
                   task.resume()
              
        }
    
}
