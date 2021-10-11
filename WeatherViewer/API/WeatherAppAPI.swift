//
//  WeatherAppAPI.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//


import Alamofire
class WeatherAppAPI: NSObject {
    private override init() {}
    
    static let sharedAPI: WeatherAppAPI = {
        let instance = WeatherAppAPI()
        var sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval.init(100)
        instance.session = Session(configuration: sessionConfig, interceptor: WeaetherAppInterceptor())
        return instance
    }()
    
    var session : Session!
    
    
    
    /// Main Post Call
    ///
    /// - Returns: Generalized Server Response
    func post<T:Codable>(_ callPath:String,
                         parameters: [String: Any]?,
                         headers: HTTPHeaders? = nil,
                         success:@escaping (T) -> Void,
                         failure:@escaping (ErrorResponse?) -> Void){
        
        
        /// merge url's from configure.plist and call path
        let url = "BASEURL" + callPath
        
        ///make the post requests with parameter and encoding
        session.request(url, method: .post, parameters: parameters, encoding : JSONEncoding.default).validate().responseDecodable{ (response:AFDataResponse<T>)  in
            
                            
            switch response.result {
            case .success(let value):
                
                success(value)
            case .failure(let error):
                
                let generalError = ErrorResponse(statusCode: response.response?.statusCode, ErrorCode : error.responseCode, ErrorMessage: callPath + ": " + error.localizedDescription)
                failure(generalError)
            }
            
            
        }
    }
    
    
    
    /// Main get call
    ///
    /// - Returns: return object
    func get<T:Codable>(_ callPath:String,
                        parameters: [String: Any]?,
                        headers: HTTPHeaders? = nil,
                        success:@escaping (T) -> Void,
                        failure:@escaping (ErrorResponse?) -> Void){
        
        //Set up base url with call path
        
        let url =  "BASEURL" + callPath
        
        
        session.request(url, method: .get, parameters: parameters, encoding : URLEncoding.default).validate().responseDecodable{ (response:AFDataResponse<T>)  in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                                
                let generalError = ErrorResponse(statusCode: response.response?.statusCode, ErrorCode : error.responseCode, ErrorMessage: callPath + ": " + error.localizedDescription)
                failure(generalError)
            }
        }
        
    }
    
    
    
   
}
