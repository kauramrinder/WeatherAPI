//
//  Service.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//

import Foundation

protocol ServiceDelegate {
    
    func ServiceDelegateDidFinishWithList(list : [String])

}
class Service {

    static var shared = Service()
    
    var delegate : ServiceDelegate?
    
        func fetchJSONData(searchText:String)  {

    
                let url = URL(string: "http://gd.geobytes.com/AutoCompleteCity?q=\(searchText)")!
                        
                       // Create (define) a task; remember that we are just defining it
                       // After the multi-line statement executes, "task" exists,
                       // but it is in a "suspended" state
                       
                       // The task requires a callback parameter, which is a Swift closure
                       // When the task completes, it will call the closure (function),
                       // and pass some arguments; all three are optional; see the docs...
                       // https://developer.apple.com/documentation/foundation/urlsession/1410330-datatask
                       
          
                        
        
                       let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                           
                           // Do two checks BEFORE attempting to extract the data from the response
                           // 1. Check whether an "error" object was passed in
                           // 2. Check that the HTTP response status is what we expect
                           
                           // If there is an error, then "error" will have something in it
                           // Otherwise, it will be nil
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
                                       print("URL: \(httpResponse.url!.path )\nStatus code: \(httpResponse.statusCode)")
                                   }
                                   return
                           }
                           
                          
                               if let data = data {
                               
                               // Create and configure a JSON decoder
                               let decoder = JSONDecoder()
                               decoder.dateDecodingStrategy = .iso8601
                        
                               do {
                                
                                   let result = try decoder.decode([String].self, from: data)
                                self.delegate?.ServiceDelegateDidFinishWithList(list : result)

                                   // Diagnostic
                                print("result in url session")
                                print(result)
                               
                                  
                               }
                               catch {
                                    print("error exception in in Amrinder's url")
                                print(error)
                               }
                           }
                       }
                       
                       // Now that "task" has been fully defined, execute it...
                       task.resume()
                  
            }
        
    }
