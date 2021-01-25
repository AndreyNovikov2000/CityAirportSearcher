//
//  ViewController.swift
//  CityAirportSearcher
//
//  Created by Andrey Novikov on 12/31/20.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Public properties
    
    var viewModelBuilder: SearchCityViewModelRespresentable.ViewModelBuilder!
    
    
    // MARK: - Private properties
    
    private var viewModel: SearchCityViewModelRespresentable!
    private let disposeBag = DisposeBag()
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<CityItemsSection>.init { (tableViewSection, tableView, indexPath, item) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: CityCell.reuseId, for: indexPath) as! CityCell
        cell.configure(withCityViewModel: item)
        return cell
    }
    
    
    
    //  MARK: - Object livecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
        setupNavigationItems()
        setupTableView()
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Airpots"
        
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: CityCell.reuseId)
        tableView.rowHeight = 100
    }
}


extension SearchCityViewController {
    private func setupBinding() {
        viewModel = viewModelBuilder((
            searchText: searchTextField.rx.text.orEmpty.asDriver(),
            selectedItem: tableView.rx.modelSelected(CityViewModel.self).asDriver()
        ))
        
        viewModel.output.cities
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}
