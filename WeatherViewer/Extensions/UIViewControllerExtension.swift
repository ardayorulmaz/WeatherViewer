//
//  UIViewControllerExtension.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 13.10.2021.
//

import Foundation
import UIKit
import NotificationBannerSwift
//Simple UIVC extension for showing informational banners using NotificationBannerSwift
extension UIViewController {
    
    func showBanner(text : String, type : NotificationBannerSwift.BannerStyle){
        let notificationBanner = NotificationBanner.init(title: "Hata", subtitle: text, style: type)
                        notificationBanner.show()
    }
}
