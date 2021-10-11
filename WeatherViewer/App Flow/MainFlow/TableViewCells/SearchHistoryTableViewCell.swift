//
//  SearchHistoryTableViewCell.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 11.10.2021.
//

import Foundation
import UIKit


// Declaring a delegate for button inside tableview cell
protocol SearchHistoryTableViewCellDelegate: AnyObject {
    func cellDeletePressed(index : Int)
    
}
class SearchHistoryTableViewCell : UITableViewCell  {
    
    
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblText: UILabel!
    
    //Reuse identifier for setting up tableview
    static let cellReuseIdentifier = "SearchHistoryTableViewCell"
    //Weak referencing for avoiding memory leaks
    weak var delegate : SearchHistoryTableViewCellDelegate?
    var cellIndex : Int? = nil
    
    func setupCell(text : String, index : Int){
        self.lblText.text = text
        self.cellIndex = index
    }
    
    @IBAction func deleteCellPressed(_ sender: Any) {
        
        guard let delegate = self.delegate, let index = self.cellIndex else {
            return
        }
        delegate.cellDeletePressed(index: index)
    }
}


