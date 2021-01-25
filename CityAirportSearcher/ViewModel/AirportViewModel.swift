//
//  AirportViewModel.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/23/21.
//

import Foundation

protocol AirportViewModelPresentable  {
    var name: String { get }
    var code: String { get }
    var location: (lat: Int, lon: Int) { get }
    var distance: Double? { get }
    var formattedDistance: String { get }
    var ranwayLenght: String { get }
}

struct AirportViewModel: AirportViewModelPresentable {
    var name: String
    var code: String
    var location: (lat: Int, lon: Int)
    var distance: Double?
    var ranwayLenght: String
    
    var formattedDistance: String {
        "\(distance?.rounded(.toNearestOrEven) ?? 0 / 1000) km"
    }
    
    init(welcomeElement: WelcomeElement) {
        name = welcomeElement.title
        code = UUID().uuidString
        location = (lat: Int.random(in: -255...255), lon: Int.random(in: -255...255))
        ranwayLenght = "Runway lenght: \(Int.random(in: 0...1000))"
        distance = 0
    }
}
