//
//  MainViewController.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import UIKit
import NotificationBannerSwift

class MainViewController : UIViewController {
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var vwWeatherConditionView: WeatherConditionView!
    
    var geolocationData : GeolocationSearchResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listenLocationChanges()
    }
    
    func loadData(){
        
        if let latLong = LocationTrackingHelper.sharedHelper.latestLocation {
            var latLongString = String(latLong.coordinate.latitude) + "," + String(latLong.coordinate.longitude)
            WeatherAPICalls.geolocationSearch(latLongString) { success in
                guard let data = success else {
                    return
                }
                self.geolocationData = data
                 
                guard let key = data.key else {
                    return
                }
                WeatherAPICalls.conditionSearch(key) { success in
                    guard let conditionData = success?[0] else {
                        return
                    }
                    self.vwWeatherConditionView.setupView(data: conditionData, locationData: data)
                } failure: { failure in
                    if let error = failure {
                        switch error.code {
                        case "400":
                            self.showBanner(text: "Hatalı arama parametreleri, arama yaptığınız kelimeyi kontrol edip tekrar deneyiniz", type: .warning)
                         
                        case "401":
                            self.showBanner(text: "API Anahtarı geçersiz, kontrol edip tekrar deneyiniz.", type: .warning)
                         
                        case "404":
                            self.showBanner(text: "Erişim hatası, daha sonra tekrar deneyiniz", type: .warning)
                                               
                        default:
                            self.showBanner(text: "Beklenmedik bir hata oluştu.", type: .warning)
                           
                        }
                    }
                   
                }


                
            } failure: { failure in
             
            }

        }
        
        
        
    }
    
    // Touch action of search field. Opens search view
    @IBAction func SearchFieldPressed(_ sender: Any) {
  
        openSearchView()
    }
    
    // Touch action of search button Opens search view
    @IBAction func SearchPressed(_ sender: Any) {
        openSearchView()
    }
    
    
    private func openSearchView(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let searchVC = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController{
            searchVC.modalPresentationStyle = .overFullScreen
            self.present(searchVC , animated: true)
        }
    }
    
    
    func listenLocationChanges(){
        NotificationCenter.default.addObserver(forName: LocationTrackingHelper.locationChangedNotification, object: nil, queue: .main) { (notification) in
                
            self.loadData()
            }
            
            
        }
    
}
