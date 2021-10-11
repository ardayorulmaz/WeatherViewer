//
//  MainViewController.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import UIKit

class MainViewController : UIViewController {
    @IBOutlet weak var txtSearchField: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    
    
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
    
}
