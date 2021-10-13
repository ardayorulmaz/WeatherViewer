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
    
    
    //Init functions for XibInstantiable
    override init(frame: CGRect) {
         super.init(frame: frame)
         instantiate()
     }
     
     required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
         instantiate()
     }
    
    //Function for setting up view`s values.
    func setupView(data : CurrentConditionsResponse, locationData : SearchResponseObject){
        
        //Setting up location`s name
        var cityNameString = locationData.localizedName
  
        if let adminAreaString = locationData.administrativeArea?.localizedName{
            cityNameString+=", "+adminAreaString
         }
        if let countryNameString = locationData.country?.localizedName {
            cityNameString+=", "+countryNameString
        }
        self.lblCityName.text = cityNameString
        //Setting up temperature string
        if let temp = data.temperature?.metric?.value, let unit = data.temperature?.metric?.unit {
            self.lblTemperature.text = String(temp) + "\u{00B0}" + unit
        }
        else {
            self.lblTemperature.text = "?"
        }
        
        //Setting up weather status text
        if let weatherStatus = data.weatherText {
            self.lblWeatherStatus.text = weatherStatus
        }else {
            self.lblTemperature.text = ""
        }
        //Splitting up time from localized time to hour and date components to show.
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
        //Using weather icons from Accuweather Api page to show related weather status icon
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
    
    //Overloading setupView for using it with geolocation data for users` own location conditions.
    func setupView(data : CurrentConditionsResponse, locationData : GeolocationSearchResponse){
        self.lblCityName.text = locationData.localizedName
        if let temp = data.temperature?.metric?.value, let unit = data.temperature?.metric?.unit {
            self.lblTemperature.text = String(temp) + "\u{00B0}" + unit
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
