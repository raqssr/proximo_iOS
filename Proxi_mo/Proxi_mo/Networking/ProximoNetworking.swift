//
//  ProximoNetworking.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation
import Malibu

enum Result<Success, Error> {
    case success(Success)
    case failure(Error)
}

enum Error: Swift.Error {
    case failedToFetch
    case failedToParse
}

struct ProximoNetworking {
    
    let networking = Networking<ProximoEndpoint>()
    static let shared = ProximoNetworking()
    
    func fetchCategories(completion: @escaping (Result<Category, Error>) -> ()) {
        networking.request(.fetchCategories)
            .validate()
            .toJsonDictionary()
            .then({ data -> Category in
                try Category(dictionary: data)
            })
            .done({ cat in
                print("A list of categories: ")
                print(cat)
                DispatchQueue.main.async {
                    completion(.success(cat))
                }
            })
            .fail({ error in
                print("Failed to fetch categories: ", error)
                completion(.failure(.failedToParse))
            })
            .always({ _ in
                print("Done")
            })
    }
    
    func fetchAllDistrics() {
        networking.request(.fetchAllDistricts)
        .validate()
        .toJsonDictionary()
        .then({ data -> District in
            return try District(dictionary: data)
        })
        .done({ districts in
          print("A list of districts: ")
          print(districts)
        })
        .fail({ error in
          print(error)
        })
        .always({ _ in
          print("Done")
        })
    }
    
    func fetchCountiesByDistrict(district: String) {
        networking.request(.fetchCountiesByDistrict(district: district))
        .validate()
        .toJsonDictionary()
        .then({ data -> County in
            return try County(dictionary: data)
        })
        .done({ counties in
          print("A list of counties: ")
          print(counties)
        })
        .fail({ error in
          print(error)
        })
        .always({ _ in
          print("Done")
        })
    }
    
    func fetchCompaniesByDistrict(district: String) {
        networking.request(.fetchCompaniesByDistrict(district: district))
        .validate()
        .toJsonDictionary()
        .then({ data -> CompanyByDistrict in
            return try CompanyByDistrict(dictionary: data)
        })
        .done({ companies in
          print("A list of companies by district: ")
          print(companies)
        })
        .fail({ error in
          print(error)
        })
        .always({ _ in
          print("Done")
        })
    }
    
    func fetchCompaniesByCounty(county: String) {
        networking.request(.fetchCompaniesByCounty(county: county))
        .validate()
        .toJsonDictionary()
        .then({ data -> CompanyByCounty in
            return try CompanyByCounty(dictionary: data)
        })
        .done({ companies in
          print("A list of companies by county: ")
          print(companies)
        })
        .fail({ error in
          print(error)
        })
        .always({ _ in
          print("Done")
        })
    }
    
    func fetchCompaniesByGeohash(geohash: String) {
        networking.request(.fetchCompaniesByGeohash(geohash: geohash))
        .validate()
        .toJsonDictionary()
        .then({ data -> CompanyByCounty in
            return try CompanyByCounty(dictionary: data)
        })
        .done({ companies in
          print("A list of companies by geohash: ")
          print(companies)
        })
        .fail({ error in
          print(error)
        })
        .always({ _ in
          print("Done")
        })
    }
}
