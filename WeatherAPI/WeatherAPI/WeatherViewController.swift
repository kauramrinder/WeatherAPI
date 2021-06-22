//
//  WeatherViewController.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    

    @IBOutlet weak var iconn: UIImageView!
    
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var temp: UILabel!
    
    var cityy : String?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = cityy
        fetchWeatherData()
        
    }
    
    func fetchWeatherData(){
        
            let manager = WeatherService()
        manager.fetchWeatherData(city: cityy ?? "", completionHandler: {
                (data) in
                DispatchQueue.main.async {
                   
                print("Weather Report : \(data.name) ")
                    
                    let icon = data.weather[0].icon
                    var url = ""
                    url = "https://openweathermap.org/img/wn/\(icon).png"
                    self.iconn.getImage(urlString: url)
                    self.humidity.text = "\(data.main?.humidity ?? 0.0)"
                    self.temp.text = "\(data.main?.temp ?? 0.0) ˚C"
                }
            }
        )
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will
     often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImageView {
public func getImage(urlString: String) {
    self.image = nil
    URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

        if error != nil {
            print(error)
            return
        }
        DispatchQueue.main.async(execute: { () -> Void in
            let img = UIImage(data: data!)
            self.image = img
        })

    }).resume()
}}
