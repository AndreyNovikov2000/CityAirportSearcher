//
//  CityCell.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/22/21.
//

import UIKit

class CityCell: UITableViewCell {

    // MARK: - External properties
    
    static let reuseId = "CityCell"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var detailCityLabel: UILabel!
    
    // MARK: - Object livecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    // MARK: - Instance meethods
    
    func configure(withCityViewModel cityViewModel: CityViewModelRepresentable) {
        cityLabel.text = cityViewModel.city
        detailCityLabel.text = cityViewModel.location
    }
}
