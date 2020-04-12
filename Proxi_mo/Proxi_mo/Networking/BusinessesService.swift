//
//  BusinessesService.swift
//  Proxi_mo
//
//  Created by raquel ramos on 10/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation
import Squid

struct BusinessesService {
    
    static let shared = BusinessesService()
    /*let service = ProximoApi()
    let request = BusinessRequest(county: "Carregal do Sal")
    lazy var response: Response<BusinessRequest> = {
        return request.schedule(with: service)
    }()*/
    
    /*let service: ProximoAp
    let request: BusinessRequest
    let response = request.schedule(with: service)*/
    
    /*let api: ProximoApi
    let request: BusinessRequest
    let response: Response<BusinessRequest>*/
    
   func fetchBusinesses(response: Response<BusinessRequest>) {
        let c = response.sink(receiveCompletion: { completion in
            switch completion {
                case .failure(let error):
                    print("Request failed due to: \(error)")
                case .finished:
                    print("Request finished.")
            }
        }) { users in
            print("Received users: \(users)")
        }
    }
}
