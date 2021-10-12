//
//  LocationDataHandler.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//
// Will Use for handling user`s location
import UIKit
import CoreLocation
import NotificationBannerSwift
class LocationTrackingHelper: NSObject, CLLocationManagerDelegate {
    var locationTask : DispatchWorkItem?
    enum LocationAccessType {
        case NotSet
        case Rejected
        case SetAlways
        case SetInUse
    }
    
    static var locationAuthorizationNotification = NSNotification.Name(rawValue: "LocationAuthorizationNotification")
    static var locationChangedNotification = NSNotification.Name(rawValue: "locationChangedNotification")
    var  latestLocation: CLLocation?
    var locationPermission : Bool = false
    var locationManager: CLLocationManager!
    static let sharedHelper: LocationTrackingHelper = {
        let instance = LocationTrackingHelper()
        instance.locationManager = CLLocationManager()
        return instance
    }()
    
    
    func configure(){
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                self.requestPermission()
            case .restricted:
                print("Not Set - Parental")
            case .denied:
                print("Not Set - Rejected")
            case .authorizedAlways:
                self.locationPermission = true
                if locationManager == nil{
                    locationManager = CLLocationManager()
                }
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = 300
                locationManager.allowsBackgroundLocationUpdates = false
                locationManager.startUpdatingLocation()
                NotificationCenter.default.post(name: LocationTrackingHelper.locationChangedNotification, object: nil, userInfo: nil)
            case .authorizedWhenInUse:
                self.locationPermission = true
                if locationManager == nil{
                    locationManager = CLLocationManager()
                    
                }
                
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = 300
                locationManager.allowsBackgroundLocationUpdates = false
                locationManager.startUpdatingLocation()
                NotificationCenter.default.post(name: LocationTrackingHelper.locationChangedNotification	, object: nil, userInfo: nil)
            @unknown default:
                do{}
            }
        }
    
   
    
    func requestPermission() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 300
        locationManager.stopUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func checkLocationAuthorizationStatus() -> LocationAccessType{
        switch CLLocationManager.authorizationStatus() {
            
            
        case .notDetermined:
            return .NotSet
        case .restricted: //"Not Set - Parental"
            return .Rejected
        case .denied: //Not Set - Rejected
            return .Rejected
        case .authorizedAlways:
            return .SetAlways
        case .authorizedWhenInUse:
            return .SetInUse
        }
        
        
    }
    
    
    func checkLocationAuthrorization()->Bool{
        switch CLLocationManager.authorizationStatus() {
            
        case .notDetermined:
            return false
        case .restricted: //"Not Set - Parental"
            return false
        case .denied: //Not Set - Rejected
            return false
        case .authorizedAlways:
            return true
        case .authorizedWhenInUse:
            return true
        @unknown default:
            return false
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        self.latestLocation = latestLocation
        
        if let locationUploadTask = self.locationTask {
            locationUploadTask.cancel()
        }
        
        self.locationTask = DispatchWorkItem {
            NotificationCenter.default.post(name: LocationTrackingHelper.locationChangedNotification, object: nil, userInfo: nil)
         
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1, execute: self.locationTask!)
        
        
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Not Set")
        case .restricted,.denied,.authorizedAlways,.authorizedWhenInUse:
            NotificationCenter.default.post(name: LocationTrackingHelper.locationAuthorizationNotification, object: nil, userInfo: nil)
        }
        
        
    }
}
