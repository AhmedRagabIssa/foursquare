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
    @IBOutlet weak var locationUpdateModeButton: UIBarButtonItem!

    private let loader = LoaderView()
    private var errorView: ErrorView?

    var viewModel: NearByPlacesViewModel = NearByPlacesViewModel()
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Near By"
        tableView.tableFooterView = UIView()
        bindLoaderState()
        registerNib()
        bindTableView()
        bindErrorState()
        bindLocationUpdateMode()
    }

    @IBAction func didPressChangeLocationUpdateMode(_ sender: Any) {
        viewModel.toggleLocationUpdateMode()
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

// MARK: - Loader
extension NearByPlacesViewController {
    private func showLoader() {
        tableView.addSubview(loader)
        loader.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        loader.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        loader.startAnimating()
    }

    private func hideLoader() {
        loader.removeFromSuperview()
        loader.stopAnimating()
    }

    private func bindLoaderState() {
        viewModel.loaderSate.asObservable().subscribe(onNext: { //2
          [unowned self] state in
            switch state {
            case .shown: self.showLoader()
            case .hidden: self.hideLoader()
            }
        }).disposed(by: disposeBag)
    }
}

// MARK: - error view
extension NearByPlacesViewController {
    private func showErrorView(with image: UIImage, message: String) {
        errorView = ErrorView(frame: tableView.frame, errorImage: image, errorMessage: message)
        if errorView != nil {
            tableView.addSubview(errorView!)
            errorView?.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 20).isActive = true
            errorView?.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: 20).isActive = true
            errorView?.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
            errorView?.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        }
    }

    private func hideErrorView() {
        errorView?.removeFromSuperview()
        errorView = nil
    }

    private func bindErrorState() {
        viewModel.errorState.asObservable().subscribe(onNext: {
            [unowned self] state in
            switch state {
            case .hidden: self.hideErrorView()
            case let .shown(image, message): self.showErrorView(with: image, message: message)
            }
            }).disposed(by: disposeBag)
    }
}

// MARK: - Location Update Mode button
extension NearByPlacesViewController {
    func bindLocationUpdateMode() {
        viewModel.locationUpdateMode.asObservable().subscribe(onNext: {
            [unowned self] mode in
            self.locationUpdateModeButton.title = mode == .realtime ? "Realtime" : "Single"
            }).disposed(by: disposeBag)
    }
}
