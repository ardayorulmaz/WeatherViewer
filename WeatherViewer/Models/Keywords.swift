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
    
    //Function to remove a certain element from keyword array
    mutating func removeAt(index : Int){
        self.keywords.remove(at: index)
        let defaults = UserDefaults.standard
        defaults.set(self.keywords, forKey: "UserSearchHistory")
    }
    
    mutating func clear(){
        self.keywords.removeAll()
        let defaults = UserDefaults.standard
        defaults.set(self.keywords, forKey: "UserSearchHistory")
    }
    
    mutating func add(text : String){
        //To remove last element if keyword list has 5 elements.
        if !keywords.isEmpty && keywords.count == 5{
            self.keywords.removeLast()
        }
        //Check to prevent adding duplicate keyword to array
        if !keywords.contains(text){
            self.keywords.insert(text, at: 0)
            let defaults = UserDefaults.standard
            defaults.set(self.keywords, forKey: "UserSearchHistory")
        }
        
  
    }
}
