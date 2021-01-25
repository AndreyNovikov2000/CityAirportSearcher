//
//  AirportViewController.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 1/22/21.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AirportViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var viewModelBuilder: AirpotsViewModelPresentable.ViewModelBuilder!
    
    // MARK: - Private properties
    
    private var disposeBag = DisposeBag()
    private var viewModel: AirpotsViewModelPresentable!
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<AirportItemSection>.init { (section, tableView, indexPath, item) in
        let cell = tableView.dequeueReusableCell(withIdentifier: AirportCell.reuseID, for: indexPath) as! AirportCell
        cell.configure(airportViewModel: item)
        return cell
    }
    
    // MARK: - Object livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBinding()
        setupTableView()
    }
}


// MARK: - Setup

extension AirportViewController {
    private func setupBinding() {
        viewModel = viewModelBuilder(Void())
        viewModel.output.title.drive(rx.title).disposed(by: disposeBag)
        viewModel.output.airports.drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        tableView.rowHeight = 175
        tableView.register(UINib(nibName: "AirportCell", bundle: nil), forCellReuseIdentifier: AirportCell.reuseID)
    }
}
