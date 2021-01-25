//
//  SearchSityViewModel.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/1/21.
//

import Foundation
import RxCocoa
import RxSwift
import RxRelay
import RxDataSources


protocol SearchCityViewModelRespresentable {
    typealias Input = (searchText: Driver<String>, selectedItem: Driver<CityViewModel>)
    typealias Output = (cities: Driver<[CityItemsSection]>, ())
    
    typealias ViewModelBuilder = (SearchCityViewModelRespresentable.Input) -> SearchCityViewModelRespresentable
    typealias State = (airports: BehaviorRelay<Set<AirportModel>>, ())
    
    typealias RouterAction = (citySelected: PublishRelay<WelcomeElement>, ())
    typealias Routing = (routing: Driver<WelcomeElement>, ())
    
    var input: SearchCityViewModelRespresentable.Input { get }
    var output: SearchCityViewModelRespresentable.Output { get }
}


// MARK: - SearchSityViewModel

final class SearchCityViewModel: SearchCityViewModelRespresentable {
    var input: (searchText: Driver<String>, selectedItem: Driver<CityViewModel>)
    var output: (cities: Driver<[CityItemsSection]>, ())
    
    private let state: SearchCityViewModelRespresentable.State = (airports: BehaviorRelay(value: []), ())
    
    private let routerAction: SearchCityViewModelRespresentable.RouterAction = (citySelected: PublishRelay(), ())
    lazy var routing: Routing = (routing: routerAction.citySelected.asDriver(onErrorDriveWith: .empty()), ())

    private var airportService: AirportAPI
    private let disposeBag = DisposeBag()
    
    init(input: SearchCityViewModelRespresentable.Input, airportService: AirportAPI) {
        self.input = input
        self.output = SearchCityViewModel.output(input: input, state: state)
        self.airportService = airportService
        
        process()
    }
}



private extension SearchCityViewModel {
    static func output(input: SearchCityViewModelRespresentable.Input,
                       state: State) -> SearchCityViewModelRespresentable.Output {
        
        let searchTextObservable = input
            .searchText
            .distinctUntilChanged()
            .debounce(.milliseconds(300))
            .asObservable()
            .share(replay: 1, scope: .whileConnected)
        
        let airportObservable = state
            .airports
            .asObservable()
        
        let sectionDriver = Observable.combineLatest(searchTextObservable, airportObservable)
            .subscribeOn(MainScheduler.instance)
            .map { (value)  in
                return value.1.first?.filter({ (element) in
                    !value.0.isEmpty && element.title.contains(value.0.lowercased())
                })
            }
            .compactMap({ $0 })
            .map(({ SearchCityViewModel.uniqueElementFrom(array: $0.compactMap({ CityViewModel(airportModel: $0) })) }))
            .map({ [CityItemsSection(model: 0, items: $0)] })
            .asDriver(onErrorJustReturn: [])
        
        return (cities: sectionDriver, ())
    }
    
    func process() {
        airportService
            .fetchAirports()
            .map({ Set(arrayLiteral: $0) })
            .map({ [state] value in
                state.airports.accept(value)
            })
            .subscribe()
            .disposed(by: disposeBag)
        
        input
            .selectedItem
            .map({ WelcomeElement(city: $0.city, coordinates: $0.location) })
            .map({ [routerAction] in
                routerAction.citySelected.accept($0)
            }).drive()
            .disposed(by: disposeBag)
    }
}

private extension SearchCityViewModel {
    static func uniqueElementFrom(array: [CityViewModel]) -> [CityViewModel] {
        var set = Set<CityViewModel>()
        let result = array.filter { (value) -> Bool in
            guard !set.contains(value) else { return false }
            set.insert(value)
            return true
        }
        
        return result
    }
}
