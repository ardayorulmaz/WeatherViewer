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
                                   success:@escaping (AutoSearchResponse) -> Void,
                                   failure:@escaping (ErrorResponse?) -> Void){
        
        // API Call for keyword search
        
        WeatherAppAPI.sharedAPI.get("locations/v1/cities/autocomplete?apikey="+ConfigurationDataHandler.shared.apiKey()+"="+keyword, parameters: nil, success: success, failure: failure);
    }
}
