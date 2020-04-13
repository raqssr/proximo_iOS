//
//  Category.swift
//  Proxi_mo
//
//  Created by raquel ramos on 13/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

enum ParseError: Error {
  case InvalidJson
}

struct Category: Codable {
    
    let categories: [String]
    
    init(dictionary: [String: Any]) throws {
      guard let categories = dictionary["categories"] as? [String]
        else {
            throw ParseError.InvalidJson
      }

        self.categories = categories
    }
    
}

