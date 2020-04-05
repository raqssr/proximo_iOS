//
//  Contact.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct Contact: Codable {
    
    let phone: [String]
    let mobile: [String]
    
    enum CodingKeys: String, CodingKey {
        case phone = "telefone"
        case mobile = "telemovel"
    }
}
