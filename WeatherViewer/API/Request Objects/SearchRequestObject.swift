//
//  SearchRequestObject.swift
//  WeatherViewer
//
//  Created by 23 Studios on 11.10.2021.
//

import Foundation
struct SearchRequestObject: Codable {
    
    var keyword : String
    
    init( keyword: String) {
        self.keyword = keyword
    
       }
}
