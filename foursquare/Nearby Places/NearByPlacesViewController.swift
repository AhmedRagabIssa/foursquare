//
//  NearByPlacesViewController.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import UIKit

class NearByPlacesViewController: UIViewController {

    var viewModel: NearByPlacesViewModel = NearByPlacesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Near By"
        viewModel.getNearByPlaces()
    }


}
