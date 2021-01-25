//
//  AirportHTTPService.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import Alamofire

class AirportHTTPService: HTTPService {
    var sessionManager: Session = Session.default
    
    func request(_ urlRequest: URLRequestConvertible) -> DataRequest {
        return sessionManager.request(urlRequest).validate(statusCode: 200..<400)
    }
}
