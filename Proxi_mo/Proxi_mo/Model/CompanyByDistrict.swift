//
//  CompanyByLocation.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct CompanyByDistrict: Codable {
    
    let district: String
    let companies: Company
    
    init(dictionary: [String: Any]) throws {
        guard let district = dictionary["district"] as? String,
            let companies = dictionary["companies"] as? Company
        else {
            throw Error.failedToParse
        }
        
        self.district = district
        self.companies = companies
    }
}
