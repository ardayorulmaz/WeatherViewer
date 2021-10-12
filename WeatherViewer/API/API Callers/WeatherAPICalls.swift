//
//  WeatherAPICalls.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import Foundation

class WeatherAPICalls: NSObject {
   	   
    static func keywordSearch (_ keyword : String,
                                   success:@escaping (AutoSearchResponse?) -> Void,
                                   failure:@escaping (ErrorResponse?) -> Void){
        
        // API Call for keyword search
        
        WeatherAppAPI.sharedAPI.get("locations/v1/cities/autocomplete?apikey="+ConfigurationDataHandler.shared.apiKey()+"&q="+keyword, parameters: nil, success: success, failure: failure);
    }
    //API Call for current conditions of location given with locationKey
    static func conditionSearch (_ locationKey : String,
                                   success:@escaping ([CurrentConditionsResponse]?) -> Void,
                                   failure:@escaping (ErrorResponse?) -> Void){
        
        // API Call for conditions search
        
        WeatherAppAPI.sharedAPI.get("currentconditions/v1/"+locationKey+"?apikey="+ConfigurationDataHandler.shared.apiKey(), parameters: nil, success: success, failure: failure);
    }
    //API Call for getting user's location from latitude and longitude
    static func geolocationSearch (_ latLong : String,
                                   success:@escaping (GeolocationSearchResponse?) -> Void,
                                   failure:@escaping (ErrorResponse?) -> Void){
        
        // API Call for geolocation search
        
        WeatherAppAPI.sharedAPI.get("locations/v1/cities/geoposition/search?apikey="+ConfigurationDataHandler.shared.apiKey()+"&q="+latLong, parameters: nil, success: success, failure: failure);
    }
}
