//
//  NearByPlacesViewController.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import UIKit
import RxSwift

class NearByPlacesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var viewModel: NearByPlacesViewModel = NearByPlacesViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Near By"
        registerNib()
        viewModel.getNearByPlaces()
        bindTableView()
    }
}

// MARK: - TableView
extension NearByPlacesViewController {
    private func registerNib() {
        tableView.register(UINib(nibName: PlaceTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PlaceTableViewCell.nibName)
    }

    private func bindTableView() {
        viewModel.venues.bind(to: tableView.rx.items(cellIdentifier: PlaceTableViewCell.nibName, cellType: PlaceTableViewCell.self)) { _, model, cell in
            cell.configure(with: model)
        }.disposed(by: disposeBag)
    }
}
