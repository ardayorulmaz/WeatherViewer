//
//  ErrorResponseObject.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//


//Base error response object for error handling			
struct ErrorResponse: Error, Codable {

    var code, message, reference: String?

    enum CodingKeys: String, CodingKey {
            case code = "Code"
            case message = "Message"
            case reference = "Reference"
        }
}
