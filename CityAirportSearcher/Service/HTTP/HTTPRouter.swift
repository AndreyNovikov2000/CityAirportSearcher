//
//  HTTPRouter.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import Alamofire

protocol HTTPRouter {
    var baseURLString: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    
    func body() throws -> Data?
    func request(httpSeervice service: HTTPService) throws -> DataRequest
}

extension HTTPRouter {
    func asURLRequest() throws -> URLRequest {
        var url = try baseURLString.asURL()
        url.appendPathComponent(path)
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = try body()

                
        return request
    }
    
    func request(httpSeervice service: HTTPService) throws -> DataRequest {
        return try service.request(asURLRequest())
    }
}
