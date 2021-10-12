//
//  SearchResponseObject.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation

struct SearchResponseObject: Codable {
    var version: Int?
    var key, type: String?
    var rank: Int?
    var localizedName: String
    var country, administrativeArea: AdministrativeArea?

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
    }
}


typealias AutoSearchResponse = [SearchResponseObject]
