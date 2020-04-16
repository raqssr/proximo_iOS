//
//  Picture.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct Picture: Codable {
    
    let logo: String?
    let outsidePicture: String?
    
    enum CodingKeys: String, CodingKey {
        case logo = "logo"
        case outsidePicture = "exterior"
    }
    
}
