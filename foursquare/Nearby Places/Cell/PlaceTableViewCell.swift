//
//  PlaceTableViewCell.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeAddressLabel: UILabel!

    static var nibName: String {
        return String(describing: self)
    }

    func configure(with venue: Venue) {
        placeNameLabel.text = venue.name ?? "No Name Available"
        placeAddressLabel.text = venue.location?.address ?? "No Address Available"
        // TODO: - display the place image
    }
}
