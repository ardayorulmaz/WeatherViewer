//
//  SearchDetailViewController.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 12.10.2021.
//

import UIKit
import NotificationBannerSwift

class SearchDetailViewController: UIViewController {

    @IBOutlet weak var vwConditionView: WeatherConditionView!
    
    @IBOutlet weak var btnClose: UIButton!
    
    var locationKey : String?
    var searchData : SearchResponseObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
    }
    
  //Loading data to show in condition view
    func loadData(){
        
        guard let searchData = self.searchData else {
            return
        }
        WeatherAPICalls.conditionSearch(searchData.key) { success in
            guard let data = success?[0] else {
                return
            }
            self.vwConditionView.setupView(data: data, locationData: searchData)
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

        
    }
    
    
    @IBAction func closePressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
 

}
