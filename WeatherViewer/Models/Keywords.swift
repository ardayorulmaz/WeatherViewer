//
//  KeywordSearchHistory.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 12.10.2021.
//

import Foundation


struct Keywords : Codable {
    var keywords : [String]
    
    
    public init(array : [String]? = nil){
        self.keywords = array ?? []
    }
    mutating func removeAt(index : Int){
        self.keywords.remove(at: index)
    }
    
    mutating func add(text : String){
        //To remove last element if keyword list has 5 elements.
        if !keywords.isEmpty && keywords.count == 5{
            self.keywords.removeLast()
        }
        
        self.keywords.insert(text, at: 0)
        let defaults = UserDefaults.standard
        defaults.set(self.keywords, forKey: "UserSearchHistory")
    }
}
