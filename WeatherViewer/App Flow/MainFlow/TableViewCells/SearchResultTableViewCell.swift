//
//  SearchResultTableViewCell.swift
//  WeatherViewer
//
//  Created by Arda Yorulmaz on 12.10.2021.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCellText: UILabel!
    
    
    static let cellReuseIdentifier = "SearchResultTableViewCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.lblCellText.text = nil
    }

    //Setting up cell`s text
    func setupCell(data : SearchResponseObject){
        
        var locationString = data.localizedName
        if let adminArea = data.administrativeArea?.localizedName {
            locationString += ", " + adminArea
        }
        if let country = data.country?.localizedName{
            locationString += ", " + country
        }
        self.lblCellText.text = locationString
    }
    
}
