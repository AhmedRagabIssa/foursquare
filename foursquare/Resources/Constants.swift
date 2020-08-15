//
//  Constants.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation

enum APIs: String {
    case forsquarePlaces = "https://api.foursquare.com/v2/venues/search"
    case forsquareVenueImage = "https://api.foursquare.com/v2/venues/"
}

enum FoursquareCredentials: String {
    case clientId = "2Z1QZ3SDQKCUU1K3QF4C222QBB0XHTTCNUBPKIDDZOQ3MC31"
    case clientSecret = "ZEEOAAZR0PL5K2UJPNRUA0W2PVOBSPRYE1MOK3GPMZJALTUN"
    case version = "20200815"
}

enum UserDefaultsKeys: String {
    case isLocationUpdateModeRealtime
}
