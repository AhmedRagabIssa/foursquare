//
//  PlaceTableViewCell.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class PlaceTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!

    private var disposeBag: DisposeBag? = DisposeBag()
    private var viewModel: PlaceCellViewModel?

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = nil
        disposeBag = DisposeBag()
    }

    static var nibName: String {
        return String(describing: self)
    }

    func configure(with venueViewModel: PlaceCellViewModel) {
        viewModel = venueViewModel
        bindObservers()
    }

    private func bindObservers() {
        viewModel?.name.bind(to: self.placeNameLabel.rx.text).disposed(by: disposeBag!)
        viewModel?.address.bind(to: self.placeAddressLabel.rx.text).disposed(by: disposeBag!)
        viewModel?.imageUrl.asObservable().subscribe(onNext: {
            [unowned self] url in
            self.placeImageView.kf.indicatorType = .activity
            self.placeImageView.kf.setImage(with: URL(string: url ?? ""), placeholder: #imageLiteral(resourceName: "imagePlaceHolder"), options: [.cacheOriginalImage])
            }).disposed(by: disposeBag!)
    }
}
