//
//  WeatherConditionView.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 12.10.2021.
//

import UIKit

class WeatherConditionView: UIView, XibInstantiatable {

    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblWeatherStatus: UILabel!
    @IBOutlet weak var lblLocalTime: UILabel!
    @IBOutlet weak var lblLocalDate: UILabel!
    @IBOutlet weak var imgWeatherImage: UIImageView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
         super.init(frame: frame)
         instantiate()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         instantiate()
     }
    
    func setupView(data : CurrentConditionsResponse, locationData : SearchResponseObject){
        self.lblCityName.text = locationData.localizedName
        if let temp = data.temperature?.metric?.value, let unit = data.temperature?.metric?.unit {
            self.lblTemperature.text = String(temp) + " " + unit
        }
        else {
            self.lblTemperature.text = "?"
        }
        if let weatherStatus = data.weatherText {
            self.lblWeatherStatus.text = weatherStatus
        }else {
            self.lblTemperature.text = ""
        }
        
        if let localTime = data.localObservationDateTime{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatterGet.date(from: localTime) {
                
                let hourFormatter = DateFormatter()
                hourFormatter.dateFormat = "HH:mm"
                self.lblLocalTime.text = hourFormatter.string(from: date)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MM yyyy"
                self.lblLocalDate.text = dateFormatter.string(from: date)
            }
            
        }
        else {
            self.lblLocalDate.text = ""
            self.lblLocalTime.text = ""
        }
        
        if let image = data.weatherIcon {
            var imageString = String(image) + "-s"
            if image<10{
                imageString = "0" + imageString
            }
            self.imgWeatherImage.image = UIImage.init(named: imageString)
        }else {
            self.imgWeatherImage.image = UIImage.init(named: "1-s")
        }
        
    }
    
    func setupView(data : CurrentConditionsResponse, locationData : GeolocationSearchResponse){
        self.lblCityName.text = locationData.localizedName
        if let temp = data.temperature?.metric?.value, let unit = data.temperature?.metric?.unit {
            self.lblTemperature.text = String(temp) + " " + unit
        }
        else {
            self.lblTemperature.text = "?"
        }
        if let weatherStatus = data.weatherText {
            self.lblWeatherStatus.text = weatherStatus
        }else {
            self.lblTemperature.text = ""
        }
        
        if let localTime = data.localObservationDateTime{
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = dateFormatterGet.date(from: localTime) {
                
                let hourFormatter = DateFormatter()
                hourFormatter.dateFormat = "HH:mm"
                self.lblLocalTime.text = hourFormatter.string(from: date)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd MM yyyy"
                self.lblLocalDate.text = dateFormatter.string(from: date)
            }
            
        }
        else {
            self.lblLocalDate.text = ""
            self.lblLocalTime.text = ""
        }
        
        if let image = data.weatherIcon {
            var imageString = String(image) + "-s"
            if image<10{
                imageString = "0" + imageString
            }
            self.imgWeatherImage.image = UIImage.init(named: imageString)
        }else {
            self.imgWeatherImage.image = UIImage.init(named: "1-s")
        }
        
    }
    

}
