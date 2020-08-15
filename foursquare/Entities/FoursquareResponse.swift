//
//  FoursquareResponse.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation

// MARK: - FoursquareResponse
struct FoursquareResponse: Codable {
    let response: Response?
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]?
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String?
    let location: Location?
}

// MARK: - Location
struct Location: Codable {
    let address: String?
}
