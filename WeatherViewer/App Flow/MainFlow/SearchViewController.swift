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
    
    var searchResults : AutoSearchResponse = []
    
    override func viewDidLoad() {
        super.viewDidLoad() 
        self.loadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //This causes window to select text field since user has clicked textfield previous screen
        self.txtSearchInput.becomeFirstResponder()
    }
    //This functions loads data required for this page.
    func loadData(){
        //Loading data from Userdefaults storage
        let defaults = UserDefaults.standard
        let savedArray = defaults.object(forKey: "UserSearchHistory") as? [String] ?? [String]()
        self.savedHistory = Keywords.init(array: savedArray)
        //reconfiguring tableviews
        self.initTableView()

    }
  
    //Setting up tableviews, assigning reusable TVC`s and various settings.
    func initTableView() {
            
        self.searchHistoryTableView.dataSource = self
        self.searchListTableView.dataSource = self
            /// setting delegate of the table view
        self.searchHistoryTableView.delegate = self
        self.searchListTableView.delegate = self
            
        /// initializing search history cell type to show on table view
        let historyCellNib = UINib(nibName: SearchHistoryTableViewCell.cellReuseIdentifier, bundle: nil)
        self.searchHistoryTableView.register(historyCellNib, forCellReuseIdentifier: SearchHistoryTableViewCell.cellReuseIdentifier)
         
        let resultCellNib = UINib(nibName: SearchResultTableViewCell.cellReuseIdentifier, bundle: nil)
        self.searchListTableView.register(resultCellNib, forCellReuseIdentifier: SearchResultTableViewCell.cellReuseIdentifier)
        
            /// Setting footer view of the table view so empty lines won't show
        self.searchHistoryTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
        self.searchListTableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1.0))
            
            /// Setting cell height to dynamic
        self.searchHistoryTableView.rowHeight = UITableView.automaticDimension
        self.searchListTableView.rowHeight = UITableView.automaticDimension
            
            ///Estimation of the cell height
        self.searchHistoryTableView.estimatedRowHeight = 60
        self.searchListTableView.estimatedRowHeight = 60
        self.cnstHistoryTableViewHeight.constant = CGFloat((savedHistory.keywords.count*45))
            
        }
    
    
    // Saving search keyword to UserDefaults, using keyword from latest clicked search result, may modify to use actual keyword that is used during search but since auto search function is active, this implementation was preferred.
    func saveSearchHistory(text : String){
       
        self.savedHistory.add(text: text)
        self.initTableView()
        self.searchHistoryTableView.reloadData()
       
    }
    //Removing deleted keyword from search history
    func removeFromSearchHistory(index : Int){
        self.savedHistory.removeAt(index: index)
        
        self.initTableView()
        self.searchHistoryTableView.reloadData()
    }
    
    func historyCellContent(index : Int)-> String {

        return savedHistory.keywords[index]
    }
    
    func delayedSearch(text : String){
        //Alternative implementation to save keyword when an auto search is initiated.
//        saveSearchHistory(text: text)
        WeatherAPICalls.keywordSearch(text) { response in
        
            guard let data = response else {
                return
            }
            
            self.searchResults = data
            if(data.isEmpty){
                self.searchListTableView.setMessage("Girdiğiniz kelime ile bir sonuç bulunamadı, lütfen başka bir kelime ile tekrar deneyiniz.")
            }
            self.searchListTableView.reloadData()
            
        } failure: { failure in
            if let error = failure {
                switch error.code {
                case "400":
                    self.searchListTableView.setMessage("Hatalı arama parametreleri, arama yaptığınız kelimeyi kontrol edip tekrar deneyiniz, noktalama işaretleri kullanmayınız")
                case "401":
                    self.searchListTableView.setMessage("API Anahtarı geçersiz, kontrol edip tekrar deneyiniz.")
                case "404":
                    self.searchListTableView.setMessage("Erişim hatası, daha sonra tekrar deneyiniz")
                default:
                    self.searchListTableView.setMessage("Beklenmedik bir hata oluştu.")
                }
            }
        }

     
    }
    @IBAction func backPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchPressed(_ sender: Any) {
        //Disabling since using auto search with autocomplete does not require a button click
//        if let searchKeyword = txtSearchInput.text {
//            delayedSearch(text: searchKeyword)
//        }
        
        
    }
    //Function to clear whole search history
    @objc func clearHistoryClicked(sender:UIButton)
    {
       
        self.savedHistory.clear()
        self.initTableView()
        self.searchHistoryTableView.reloadData()
    }
}


extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    
    
 
        // Setting section header height of setting page's table's sections.
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            if(tableView == self.searchHistoryTableView){
                return 50
            }
            else {
                return 0
            }
        }
        
        // Setting up a button to delete whole search history
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            if(tableView == self.searchHistoryTableView){
            let headerView = UIView.init(frame: CGRect.init(x:0, y: 0, width: UIScreen.main.bounds.size.width, height: 50))
            headerView.backgroundColor = UIColor.white
            headerView.clipsToBounds = true
            
            let label = UILabel()
            
            label.frame = CGRect.init(x: UIScreen.main.bounds.maxX-115, y: 15, width: 100, height: headerView.frame.height)
            label.textAlignment = .right
            label.text = "Temizle"
            label.font = UIFont.systemFont(ofSize: 15, weight: .semibold )
            label.textColor = .black
                
            headerView.addSubview(label)
                
            //Settong up button for clear historyAction
            let button = UIButton()
            button.frame = label.frame
            button.addTarget(target, action: #selector(clearHistoryClicked(sender:)), for: .touchUpInside);
            headerView.addSubview(button)
            
            
            return headerView
            }
            return UIView()
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case searchHistoryTableView:
            return self.savedHistory.keywords.count
        case searchListTableView:
            return self.searchResults.count
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
            if let cell:SearchResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.cellReuseIdentifier) as? SearchResultTableViewCell {
                
                cell.setupCell(data: searchResults[indexPath.row])
                return cell
            }else {
                return UITableViewCell()
            }
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case searchListTableView:
            
            //Since auto search is implemented, preferred to choose selected cell`s data`s localized name as keyword to save.
            //Keyword is saved when cell is selected.
            self.saveSearchHistory(text: searchResults[indexPath.row].localizedName)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            if let searchDetailVC = storyBoard.instantiateViewController(withIdentifier: "SearchDetailViewController") as? SearchDetailViewController{
                searchDetailVC.modalPresentationStyle = .overFullScreen
                searchDetailVC.searchData = searchResults[indexPath.row]
                self.present(searchDetailVC , animated: true)
            }
        case searchHistoryTableView:
            self.delayedSearch(text: savedHistory.keywords[indexPath.row])
        default:
            do{}
            
        }
    }
    
    
    
    
}

extension SearchViewController : SearchHistoryTableViewCellDelegate {
    func cellDeletePressed(index: Int) {
        self.removeFromSearchHistory(index: index)
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
