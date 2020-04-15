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

class ProximoNetworking {
    
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
                // print("A list of categories: ")
                // print(cat)
                DispatchQueue.main.async {
                    completion(.success(cat))
                }
            })
            .fail({ error in
                print("Failed to fetch categories: ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ...
            })
    }
    
    func fetchAllDistricts(completion: @escaping (Result<District, Error>) -> ()) {
        networking.request(.fetchAllDistricts)
            .validate()
            .toJsonDictionary()
            .then({ data -> District in
                try District(dictionary: data)
            })
            .done({ districts in
                // print("A list of districts: ")
                // print(districts)
                DispatchQueue.main.async {
                    completion(.success(districts))
                }
            })
            .fail({ error in
                print("Failed to fetch districts: ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ...
            })
    }
    
    func fetchAllCounties(completion: @escaping (Result<CountyList, Error>) -> ()) {
        networking.request(.fetchAllCounties)
            .validate()
            .toJsonDictionary()
            .then({ data -> CountyList in
                try CountyList(dictionary: data)
            })
            .done({ counties in
                print("All the counties: ")
                print(counties)
                DispatchQueue.main.async {
                    completion(.success(counties))
                }
            })
            .fail({ error in
                print("Failed to fetch all the counties: ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ...
            })
    }
    
    func fetchCountiesByDistrict(district: String, completion: @escaping (Result<County, Error>) -> ()) {
        networking.request(.fetchCountiesByDistrict(district: district))
            .validate()
            .toJsonDictionary()
            .then({ data -> County in
                try County(dictionary: data)
            })
            .done({ counties in
                print("Counties in \(district): ")
                print(counties)
                DispatchQueue.main.async {
                    completion(.success(counties))
                }
            })
            .fail({ error in
                print("Failed to fetch counties from \(district): ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ...
            })
    }
    
    // ERROR HERE (MAYBE DOESN'T WORK WITH CODABLE?)
    // https://api.proxi-mo.pt/companies_by_location?district=Aveiro
    func fetchCompaniesByDistrict(district: String, completion: @escaping (Result<CompanyByDistrict, Error>) -> ()) {
        networking.request(.fetchCompaniesByDistrict(district: district))
            .validate()
            .toJsonDictionary()
            .then({ data -> CompanyByDistrict in
                try CompanyByDistrict(dictionary: data)
            })
            .done({ companies in
                print("List of companies in \(district): ")
                print(companies)
                DispatchQueue.main.async {
                    completion(.success(companies))
                }
            })
            .fail({ error in
                print("Failed to fetch companies from \(district): ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ...
            })
    }
    
    // NOT DONE YET
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
    
    // NOT DONE YET
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
