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
    let decoder = JSONDecoder()
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
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
    
    func fetchCompaniesByDistrict(district: String, completion: @escaping (Result<CompanyByDistrict, Error>) -> ()) {
        let networkPromise = networking.request(.fetchCompaniesByDistrict(district: district))
        networkPromise.validate()
            .toJsonDictionary()
            .then({ _ in
                networkPromise.decode(using: CompanyByDistrict.self, decoder: self.decoder)
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
    
    func fetchCompaniesByCounty(county: String, completion: @escaping (Result<CompanyByCounty, Error>) -> ()) {
        let networkPromise = networking.request(.fetchCompaniesByCounty(county: county))
        networkPromise.validate()
            .toJsonDictionary()
            .then({ _ in
                networkPromise.decode(using: CompanyByCounty.self, decoder: self.decoder)
            })
            .done({ companies in
                print("List of companies in \(county): ")
                print(companies)
                DispatchQueue.main.async {
                    completion(.success(companies))
                }
            })
            .fail({ error in
                print("Failed to fetch companies from \(county): ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ..
            })
    }
    
    func fetchCompaniesByGeohash(geohash: String, completion: @escaping (Result<CompanyByCounty, Error>) -> ()) {
        let networkPromise = networking.request(.fetchCompaniesByGeohash(geohash: geohash))
        networkPromise.validate()
            .toJsonDictionary()
            .then({ _ in
                networkPromise.decode(using: CompanyByCounty.self, decoder: self.decoder)
            })
            .done({ companies in
                print("A list of companies by geohash \(geohash): ")
                print(companies)
                DispatchQueue.main.async {
                    completion(.success(companies))
                }
            })
            .fail({ error in
                print("Failed to fetch companies from geohash \(geohash): ", error)
                completion(.failure(.failedToFetch))
            })
            .always({ _ in
                // ..
            })
    }
}
