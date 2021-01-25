//
//  AirportAPI.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import RxSwift

protocol AirportAPI {
    func fetchAirports() -> Single<AirportModel>
}

extension AirportAPI {
    func decode<T: Decodable>(data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
