//
//  CustomError.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/3/21.
//

import Foundation

enum CustomError: Error {
    case error(value: String)
}

enum NetworkError: Error {
    case parametrsNil
}
