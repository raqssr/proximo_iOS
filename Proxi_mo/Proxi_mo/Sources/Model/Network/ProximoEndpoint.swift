//
//  ProximoEndpoint.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation
import Malibu

enum ProximoEndpoint: RequestConvertible {
  
    // Describe requests
    case fetchCategories
    case fetchAllDistricts
    case fetchAllCounties
    case fetchCountiesByDistrict(district: String)
    case fetchCompaniesByDistrict(district: String)
    case fetchCompaniesByCounty(county: String)
    case fetchCompaniesByGeohash(geohash: String)

    // Every request will be scoped by the base url
    // Base url is recommended, but optional
    static var baseUrl: URLStringConvertible? = "https://api-teste.proxi-mo.pt/"
    static let sessionConfiguration: SessionConfiguration = .default
    
    // Additional headers for every request
    static var headers: [String: String] = [
        "Accept":"application/json"
    ]

    // Build requests
    var request: Request {
        switch self {
        case .fetchCategories:
            return Request.get("categories")
        case .fetchAllDistricts:
            return Request.get("all_districts")
        case .fetchAllCounties:
            return Request.get("all_counties")
        case .fetchCountiesByDistrict(let district):
            return Request.get("counties_by_distric", parameters: ["district": district])
        case .fetchCompaniesByDistrict(let district):
            return Request.get("companies_by_location", parameters: ["district": district])
        case .fetchCompaniesByCounty(let county):
            return Request.get("companies_by_location", parameters: ["county": county])
        case .fetchCompaniesByGeohash(let geohash):
            return Request.get("companies_by_location", parameters: ["geohash": geohash])
        }
    }
}
