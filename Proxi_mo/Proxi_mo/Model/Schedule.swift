//
//  Schedule.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct Schedule: Codable {
    
    let monday: [String]
    let tuesday: [String]
    let wednesday: [String]
    let thrusday: [String]
    let friday: [String]
    let saturday: [String]
    
    enum CodingKeys: String, CodingKey {
        case monday = "segunda"
        case tuesday = "terça"
        case wednesday = "quarta"
        case thrusday = "quinta"
        case friday = "sexta"
        case saturday = "sabado"
    }
    
}
