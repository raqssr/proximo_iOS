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
    let sunday: [String]
    
    enum CodingKeys: String, CodingKey {
        case monday = "segunda-feira"
        case tuesday = "terça-feira"
        case wednesday = "quarta-feira"
        case thrusday = "quinta-feira"
        case friday = "sexta-feira"
        case saturday = "sábado"
        case sunday = "domingo"
    }
    
}
