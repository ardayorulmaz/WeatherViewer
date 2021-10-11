//
//  SearchViewController.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import UIKit


class SearchViewController : UIViewController {
    
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var searchListTableView: UITableView!
    @IBOutlet weak var txtSearchInput: UITextField!
    
    
    
    //Setting up tableviews, assigning reusable TVC`s and various settings.
    func initTableView() {
            
        self.searchHistoryTableView.dataSource = self
            
            /// setting delegate of the table view
        self.searchHistoryTableView.delegate = self
            
            
            /// initializing search history cell type to show on table view
            let historyCellNib = UINib(nibName: SearchHistoryTableViewCell.cellReuseIdentifier, bundle: nil)
            self.searchHistoryTableView.register(historyCellNib, forCellReuseIdentifier: SearchHistoryTableViewCell.cellReuseIdentifier)
         
            /// Setting footer view of the table view so empty lines won't show
        self.searchHistoryTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 150.0))
            
            /// Setting cell height to dynamic
        self.searchHistoryTableView.rowHeight = UITableView.automaticDimension
            
            ///Estimation of the cell height
        self.searchHistoryTableView.estimatedRowHeight = 60
            
        }
    
    
    
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchPressed(_ sender: Any) {
        
        let searchKeyword = txtSearchInput.text
        
    }
}


extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case searchHistoryTableView:
            do{}
        case searchListTableView:
            do{}
        default:
            do{}
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
    
}
	
