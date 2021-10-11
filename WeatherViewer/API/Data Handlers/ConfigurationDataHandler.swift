//
//  ConfigurationDataHandler.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation

//This class handles configuration parameters written to info.plist file
class ConfigurationDataHandler: NSObject {
    
    var fullPlist : NSDictionary!
    
    static let shared: ConfigurationDataHandler = {
        let instance = ConfigurationDataHandler()
        var nsDictionary: NSDictionary?
        if let path = Bundle.main.path(forResource: "Configuration", ofType: "plist") {
            instance.fullPlist = NSDictionary(contentsOfFile: path)
        }
        return instance
    }()
    
    // Returns API's baseURL.
    func baseUrl() -> String{
        
        guard let plist = fullPlist, let url = plist["BaseURL"] as? String else{
            fatalError("could not find backEndURL on Configuration.plist")
        }
        
        return url
    }
    
    //Returns API key, which has 50 call/day limit for free package.
    func apiKey() -> String{
        
        guard let plist = fullPlist, let url = plist["APIKey"] as? String else{
            fatalError("could not find APIKey on Configuration.plist")
        }
        
        return url
    }
    
    
 
       
}
