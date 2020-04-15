//
//  Business.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct Business: Codable {
    
    let id: String?
    let name: String
    let website: String?
    let district: String
    let county: String
    let parish: String
    let address: String
    let gmapsUrl: String?
    let long: Double?
    let lat: Double?
    let geoHash: String?
    let delivery: Bool?
    let notes: String?
    let pictures: Picture?
    let contacts: Contact
    let socialNetworks: SocialNetwork?
    let categories: [String]
    let schedule: Schedule
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case website = "website"
        case district = "district"
        case county = "county"
        case parish = "parish"
        case address = "address"
        case gmapsUrl = "gmaps_url"
        case long = "longitude"
        case lat = "latitude"
        case geoHash = "geo_hash"
        case delivery = "home_delivery"
        case notes = "notes"
        case pictures = "images"
        case contacts = "contacts"
        case socialNetworks = "social"
        case categories = "categories"
        case schedule = "schedules"
    }
}
