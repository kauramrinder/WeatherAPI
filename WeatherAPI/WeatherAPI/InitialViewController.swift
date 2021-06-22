//
//  InitialViewController.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//

import UIKit

class InitialViewController: UITableViewController {

    @IBOutlet weak var btn_add: UIBarButtonItem!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
        
        var cities : [CityDb] = [CityDb]()

        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            fetchCities()
            self.searchBar.delegate = self
        }
        
        func fetchCities() {
            cities = CoreDataManager.shared.fetchCityFromCoreData()
            tableView.reloadData()
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print("You selected : \(cities[indexPath.row])")
            
            let weatherViewController = storyboard?.instantiateViewController(identifier: "WeatherViewController") as? WeatherViewController
                   
            weatherViewController?.cityy = (cities[indexPath.row].cityName)
                   
           self.navigationController?.pushViewController(weatherViewController!, animated: true)
                  
       }
       override func numberOfSections(in tableView: UITableView) -> Int {
        
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return cities.count
        
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

           cell.textLabel?.text = cities[indexPath.row].cityName
            cell.detailTextLabel?.text = cities[indexPath.row].countryName
           return cell
       }
       
       // Override to support conditional editing of the table view.
       override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
           return true
       }
       

       // Override to support editing the table view.
       override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
           if editingStyle == .delete {
              
               CoreDataManager.shared.deleteCity(city: cities[indexPath.row])
            
               fetchCities()

           }
       }
        
        override func viewWillAppear(_ animated: Bool) {
               super.viewWillAppear(animated)
               
            fetchCities()
            
            tableView.reloadData()
            
        }
    }


    extension InitialViewController : UISearchBarDelegate{
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if (searchText == ""){
                fetchCities()
            }
            else {
            cities = CoreDataManager.shared.search(text: searchText)
             tableView.reloadData()
            }
        }
    }
