//
//  AirportCell.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/23/21.
//

import UIKit

class AirportCell: UITableViewCell {
    
    static let reuseID = "AirportCell"
    
    @IBOutlet weak var aiportNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var lenghtLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    func configure(airportViewModel: AirportViewModelPresentable) {
        aiportNameLabel.text = airportViewModel.name
        locationLabel.text = "lat: \(airportViewModel.location.lat), lon: \(airportViewModel.location.lon)"
        lenghtLabel.text = airportViewModel.ranwayLenght
    }
}
