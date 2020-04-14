//
//  County.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct County: Codable {
    
    let district: String
    let counties: [[String]]
    
    init(dictionary: [String: Any]) throws {
        guard let district = dictionary["district"] as? String,
            let counties = dictionary["counties"] as? [[String]]
        else {
            throw Error.failedToParse
        }
        
        self.district = district
        self.counties = counties
    }
}
