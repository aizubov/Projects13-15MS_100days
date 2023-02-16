//
//  Country.swift
//  Project7_100days
//
//  Created by user228564 on 2/15/23.
//

import Foundation

struct Country: Codable {
    var country: String
    var abbreviation: String
    var city: String?
    var currency_name: String?
    var government: String?
    var population: Int?
}
