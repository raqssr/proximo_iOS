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
    let companies: [String: Company]
}
