//
//  AirpotsViewModel.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/22/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

typealias AirportItemSection = SectionModel<Int, AirportViewModel>

protocol AirpotsViewModelPresentable {
    typealias Input = ()
    typealias Output = (title: Driver<String>, airports: Driver<[AirportItemSection]>)
    typealias ViewModelBuilder = (AirpotsViewModelPresentable.Input) -> AirpotsViewModelPresentable
    typealias Dependecies = (title: String, model: WelcomeElement)

    
    var input: AirpotsViewModelPresentable.Input { get set }
    var output: AirpotsViewModelPresentable.Output { get set }
}

final class AirpotsViewModel: AirpotsViewModelPresentable {
    var input: ()
    var output: (title: Driver<String>, airports: Driver<[AirportItemSection]>)
    var dependecies: Dependecies
    
    init(input: AirpotsViewModelPresentable.Input, dependecies: AirpotsViewModelPresentable.Dependecies) {
        self.input = input
        self.dependecies = dependecies
        self.output = AirpotsViewModel.output(input: input, dependecies: dependecies)
    }
}

extension AirpotsViewModel {
    static func output(input: AirpotsViewModelPresentable.Input,
                       dependecies: AirpotsViewModelPresentable.Dependecies) -> AirpotsViewModelPresentable.Output {

        let section = Driver
            .just(dependecies.model)
            .map({ AirportViewModel(welcomeElement: $0) })
            .map({ [AirportItemSection(model: 0, items: [$0])] })
            .asDriver()
        
        return (title: Driver.just(dependecies.title),
                airports: section)
    }
}
