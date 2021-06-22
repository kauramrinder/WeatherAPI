//
//  CityDb+CoreDataProperties.swift
//  WeatherAPI
//
//  Created by user182438 on 12/12/20.
//  Copyright © 2020 user182438(AmrinderKaur). All rights reserved.
//
//

import Foundation
import CoreData


extension CityDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityDb> {
        return NSFetchRequest<CityDb>(entityName: "CityDb")
    }

    @NSManaged public var countryName: String?
    @NSManaged public var cityName: String?

}
