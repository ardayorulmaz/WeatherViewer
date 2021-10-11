//
//  ErrorResponseObject.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//


//Base error response object for error handling
struct ErrorResponse: Error, Codable {

    var statusCode : Int?
    var ErrorCode : Int?
    var ErrorMessage: String?

    
}

