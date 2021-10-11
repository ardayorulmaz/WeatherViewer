//
//  WeatherAppAPIHelper.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import UIKit
import Alamofire

class WeaetherAppInterceptor: RequestInterceptor {
    typealias AdapterResult = Swift.Result<URLRequest, Error>
    
    private var baseURLString: String =  "BASEURL"
    private let lock = NSLock()
    
    private var nonLoginHeaders: [String : String]{
            get {
                return [
                    "X-Authorization": "Token " ,
                    "Authorization": "AUTH",
                    "Content-Type" : "application/json"
                ]
            }
        }
  
    
    
    // MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (AdapterResult) -> Void) {
        
        if let urlString = urlRequest.url?.absoluteString, urlString.hasPrefix(baseURLString) {
            var adaptedRequest = urlRequest
            
           
                adaptedRequest.allHTTPHeaderFields?.merge(nonLoginHeaders, uniquingKeysWith: { (_, new) -> String in
                    new
                })
            
            
            //If I inspect the adaptedRequest right here.. it DOES have the Headers, if it went thru the right conditional above.
            completion(.success(adaptedRequest))
            return
        }
        completion(.success(urlRequest))
        return
    }
    
    
    
    // MARK: - RequestRetrier
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        lock.lock() ; defer { lock.unlock() }
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            
            request.cancel()
        } else {
            completion(.doNotRetry)
        }
        
    }
}
