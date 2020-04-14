//
//  District.swift
//  Proxi_mo
//
//  Created by raquel ramos on 14/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct District: Codable {
    
    let districts: [String]
    
    init(dictionary: [String: Any]) throws {
        guard let districts = dictionary["districts"] as? [String]
        else {
            throw Error.failedToParse
        }
        
        self.districts = districts
    }
}
