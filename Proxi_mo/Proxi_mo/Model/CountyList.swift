//
//  CountyList.swift
//  Proxi_mo
//
//  Created by raquel ramos on 15/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct CountyList: Codable {
    
    let counties: [String: [[String]]]
    
    init(dictionary: [String: Any]) throws {
        guard let counties = dictionary["counties"] as? [String: [[String]]]
        else {
            throw Error.failedToParse
        }
        
        self.counties = counties
    }
}
