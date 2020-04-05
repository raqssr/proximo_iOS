//
//  Business.swift
//  Proxi_mo
//
//  Created by raquel ramos on 05/04/2020.
//  Copyright © 2020 raquel ramos. All rights reserved.
//

import Foundation

struct Business: Codable {
    
    let id: Int
    let name: String
    let website: String?
    let district: String
    let county: String
    let parish: String
    let address: String
    let gmapsUrl: String
    let long: Double
    let lat: Double
    let geoHash: String?
    let delivery: Bool
    let notes: String?
    let pictures: Picture
    let contacts: Contact
    let socialNetworks: SocialNetwork
    let categories: [String]
    let schedule: Schedule
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "nome"
        case website = "website"
        case district = "distrito"
        case county = "concelho"
        case parish = "freguesia"
        case address = "morada"
        case gmapsUrl = "gmaps_url"
        case long = "longitude"
        case lat = "latitude"
        case geoHash = "geo_hash"
        case delivery = "entrega_em_cas"
        case notes = "notas"
        case pictures = "imagens"
        case contacts = "contactos"
        case socialNetworks = "redes_sociais"
        case categories = "categorias"
        case schedule = "horario"
    }
}
