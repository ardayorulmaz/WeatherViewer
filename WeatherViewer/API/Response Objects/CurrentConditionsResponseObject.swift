//
//  CurrentConditionsResponseObject.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation

// MARK: - CurrentConditionsResponeObject
struct CurrentConditionsResponeObject: Codable {
    var localObservationDateTime: Date?
    var epochTime: Int?
    var weatherText: String?
    var weatherIcon: Int?
    var hasPrecipitation: Bool?
    var precipitationType: String?
    var isDayTime: Bool?
    var temperature: Temperature?
    var mobileLink, link: String?

    enum CodingKeys: String, CodingKey {
        case localObservationDateTime = "LocalObservationDateTime"
        case epochTime = "EpochTime"
        case weatherText = "WeatherText"
        case weatherIcon = "WeatherIcon"
        case hasPrecipitation = "HasPrecipitation"
        case precipitationType = "PrecipitationType"
        case isDayTime = "IsDayTime"
        case temperature = "Temperature"
        case mobileLink = "MobileLink"
        case link = "Link"
    }
}

// MARK: - Temperature
struct Temperature: Codable {
    var metric, imperial: Imperial?

    enum CodingKeys: String, CodingKey {
        case metric = "Metric"
        case imperial = "Imperial"
    }
}
