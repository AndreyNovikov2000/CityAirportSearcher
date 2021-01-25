//
//  HTTPService.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import Alamofire

protocol HTTPService {
    var sessionManager: Session { get set }
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest
}
