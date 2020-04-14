//
//  CompanyByCounty.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct CompanyByCounty: Codable {
    
    let county: String
    let companies: Company
    
    init(dictionary: [String: Any]) throws {
        guard let county = dictionary["county"] as? String,
            let companies = dictionary["companies"] as? Company
        else {
            throw Error.failedToParse
        }
        
        self.county = county
        self.companies = companies
    }
}
