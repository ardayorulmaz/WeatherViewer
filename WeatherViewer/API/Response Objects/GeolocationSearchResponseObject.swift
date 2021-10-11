//
//  GeolocationSearchResponseObject.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//
import Foundation

// MARK: - GeolocationSearchResponse
struct GeolocationSearchResponse: Codable {
    var version: Int?
    var key, type: String?
    var rank: Int?
    var localizedName, englishName, primaryPostalCode: String?
    var region, country: Country?
    var administrativeArea: AdministrativeArea?
    var timeZone: TimeZone?
    var geoPosition: GeoPosition?
    var isAlias: Bool?
    var parentCity: ParentCity?
    var supplementalAdminAreas: [SupplementalAdminArea]?
    var dataSets: [String]?

    enum CodingKeys: String, CodingKey {
        case version = "Version"
        case key = "Key"
        case type = "Type"
        case rank = "Rank"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case primaryPostalCode = "PrimaryPostalCode"
        case region = "Region"
        case country = "Country"
        case administrativeArea = "AdministrativeArea"
        case timeZone = "TimeZone"
        case geoPosition = "GeoPosition"
        case isAlias = "IsAlias"
        case parentCity = "ParentCity"
        case supplementalAdminAreas = "SupplementalAdminAreas"
        case dataSets = "DataSets"
    }
}

// MARK: - AdministrativeArea
struct AdministrativeArea: Codable {
    var id, localizedName, englishName: String?
    var level: Int?
    var localizedType, englishType, countryID: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
        case level = "Level"
        case localizedType = "LocalizedType"
        case englishType = "EnglishType"
        case countryID = "CountryID"
    }
}

// MARK: - Country
struct Country: Codable {
    var id, localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - GeoPosition
struct GeoPosition: Codable {
    var latitude, longitude: Double?
    var elevation: Elevation?

    enum CodingKeys: String, CodingKey {
        case latitude = "Latitude"
        case longitude = "Longitude"
        case elevation = "Elevation"
    }
}

// MARK: - Elevation
struct Elevation: Codable {
    var metric, imperial: Imperial?

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}

// MARK: - Imperial
struct Imperial: Codable {
    var value: Int?
    var unit: String?
    var unitType: Int?

    enum CodingKeys: String, CodingKey {
        case value = "Value"
        case unit = "Unit"
        case unitType = "UnitType"
    }
}

// MARK: - ParentCity
struct ParentCity: Codable {
    var key, localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case key = "Key"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - SupplementalAdminArea
struct SupplementalAdminArea: Codable {
    var level: Int?
    var localizedName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case level = "Level"
        case localizedName = "LocalizedName"
        case englishName = "EnglishName"
    }
}

// MARK: - TimeZone
struct TimeZone: Codable {
    var code, name: String?
    var gmtOffset: Int?
    var isDaylightSaving: Bool?
    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case gmtOffset = "GmtOffset"
        case isDaylightSaving = "IsDaylightSaving"
    }
}

