//
//  AirportHTTPRouter.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import Alamofire

enum AirportHTTPRouter {
    case getAirports
}


extension AirportHTTPRouter: HTTPRouter {
    var baseURLString: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getAirports:
            return "/posts"
        }
    }
    
    
    var method: HTTPMethod {
        switch self {
        case .getAirports:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getAirports:
            return nil
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getAirports:
            return nil
        }
    }
    
    func body() throws -> Data? {
        return nil
    }
}
