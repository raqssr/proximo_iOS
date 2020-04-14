//
//  CategoriesService.swift
//  Proxi_mo
//
//  Created by raquel ramos on 13/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation
import Malibu
import When

struct CategoriesService {
    
    // Create your request => GET http://sharkywaters.com/api/boards?type=1
    let request = Request.get("https://api.proxi-mo.pt/categories")
    static let shared = CategoriesService()
    
    func fetchCategories() {
        Malibu.request(request)
            .validate()
            .toJsonDictionary()
            .then({ data -> Category in
                return try Category(dictionary: data)
                
            })
            .done({ categories in
                print(categories)
            })
            .fail({ error in
                print(error)
            })
            .always({ _ in
                print("Done")
            })
    }
}
