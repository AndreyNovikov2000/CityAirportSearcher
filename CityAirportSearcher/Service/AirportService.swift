//
//  AirportService.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/19/21.
//

import Foundation
import RxSwift

class AirportService {
    private lazy var httpService = AirportHTTPService()
    static let shared = AirportService()
}



// MARK: - AitportAPI

extension AirportService: AirportAPI {
    func fetchAirports() -> Single<AirportModel> {
        return Single.create { [weak self] (single) -> Disposable in
            guard let self = self else {
                return Disposables.create()
            }
            
            do {
                try AirportHTTPRouter.getAirports.request(httpSeervice: self.httpService).responseJSON { (result) in
                    if let error = result.error {
                        single(.error(error))
                        return
                    }
                    
                    guard let data = result.data else {
                        single(.error(NetworkError.parametrsNil))
                        return
                    }
                    
                    do {
                        let decoded: AirportModel = try self.decode(data: data)
                        single(.success(decoded))
                        
                    } catch {
                        single(.error(error))
                    }
                }
            } catch {
                single(.error(error))
            }
            
            return Disposables.create()
        }
    }
}

