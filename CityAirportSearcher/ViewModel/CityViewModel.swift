//
//  CityViewModel.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/22/21.
//

import Foundation
import RxDataSources

typealias CityItemsSection = SectionModel<Int, CityViewModel>

protocol CityViewModelRepresentable {
    var city: String { get }
    var location: String { get }
}

struct CityViewModel: CityViewModelRepresentable {
    var city: String
    var location: String
    
    init(airportModel: WelcomeElement) {
        self.city = airportModel.title
        self.location = "location: \(Int.random(in: -255...255))"
    }
}

extension CityViewModel: Hashable {
    static func == (lhs: CityViewModel, rhs: CityViewModel) -> Bool {
        lhs.city == rhs.city && lhs.location == rhs.location
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(city)
    }
}
