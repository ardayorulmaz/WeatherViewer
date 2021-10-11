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
    @IBOutlet weak var cnstHistoryTableViewHeight: NSLayoutConstraint!
    
    //Dispatch work item for delayed auto search function
    var textTypingDispatch : DispatchWorkItem?
    
    var mockHistoryArray = ["never","gonna", "give", "you", "up"]
    
    //Struct for saving keywords
    var savedHistory : Keywords = Keywords()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
       
    }
    
    //This functions loads data required for this page.
    func loadData(){
        //Saving data to Userdefaults storage
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "UserSearchHistory") as? [String] ?? [String]()
        savedHistory = Keywords.init(array: savedArray)
        //reconfiguring tableviews
        initTableView()
    }
    func saveSearchHistory(text : String){
       
        savedHistory.add(text: text)
        initTableView()
       
    }
    func removeFromSearchHistory(index : Int){
        savedHistory.removeAt(index: index)
        initTableView()
    }
    //Setting up tableviews, assigning reusable TVC`s and various settings.
    func initTableView() {
            
        self.searchHistoryTableView.dataSource = self
            
            /// setting delegate of the table view
        self.searchHistoryTableView.delegate = self
            
            
            /// initializing search history cell type to show on table view
            let historyCellNib = UINib(nibName: SearchHistoryTableViewCell.cellReuseIdentifier, bundle: nil)
            self.searchHistoryTableView.register(historyCellNib, forCellReuseIdentifier: SearchHistoryTableViewCell.cellReuseIdentifier)
         
            /// Setting footer view of the table view so empty lines won't show
        self.searchHistoryTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
            
            /// Setting cell height to dynamic
        self.searchHistoryTableView.rowHeight = UITableView.automaticDimension
            
            ///Estimation of the cell height
        self.searchHistoryTableView.estimatedRowHeight = 60
        cnstHistoryTableViewHeight.constant = CGFloat((mockHistoryArray.count*60))
            
        }
    
    
    func historyCellContent(index : Int)-> String {
      ````
        return savedHistory.keywords[index]
    }
    
    func delayedSearch(text : String){
      //TODO
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
            return mockHistoryArray.count
        case searchListTableView:
           return 0
        default:
           return 0
        }
    }
    
    	
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Switch case for different tableviews
        switch tableView {
        case searchHistoryTableView:
            
            if let cell:SearchHistoryTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchHistoryTableViewCell.cellReuseIdentifier) as? SearchHistoryTableViewCell {
                
                cell.delegate = self
                cell.setupCell(text: historyCellContent(index: indexPath.row), index: indexPath.row)
                return cell
            }else {
                return UITableViewCell()
            }
        case searchListTableView:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    
    
    
}

extension SearchViewController : SearchHistoryTableViewCellDelegate {
    func cellDeletePressed(index: Int) {
     //TODO
    }
    
    
}
	//Extension for detecting test type event in UITextfield
extension SearchViewController : UITextFieldDelegate{
    // Function for delayed live search.
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if let textTyping = self.textTypingDispatch{
            textTyping.cancel()
        }
        if self.txtSearchInput.text!.trimmingCharacters(in: .whitespacesAndNewlines).count >= 2 {
            self.textTypingDispatch = DispatchWorkItem {
                if let textToSearch = self.txtSearchInput.text{
                    self.delayedSearch(text: textToSearch)
                }
                
            }
            if let textTyping = self.textTypingDispatch{
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: textTyping)
            }
        }
        return true
    }
    
    
    
    
}
