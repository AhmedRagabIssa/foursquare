//
//  PlaceCellViewModel.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/16/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation
import RxCocoa

class PlaceCellViewModel {

    private let venue: Venue
    var name: BehaviorRelay<String?>
    var address: BehaviorRelay<String?>
    var imageUrl: BehaviorRelay<String?> = BehaviorRelay(value: nil)

    init(venue: Venue) {
        self.venue = venue
        name = BehaviorRelay(value: venue.name ?? "No Name Available")
        address = BehaviorRelay(value: venue.location?.address ?? "No Address Available")
        if let id = venue.id {
            getImageForVenue(with: id)
        }
    }

    private func getImageForVenue(with id: String) {
        let imageRequest = SimpleGetRequest(url: "\(APIs.forsquareVenueImage.rawValue)\(id)/photos",
                                            parameters : ["client_id"     : FoursquareCredentials.clientId.rawValue,
                                                          "client_secret" : FoursquareCredentials.clientSecret.rawValue,
                                                          "limit"         : 1,
                                                          "v"             : FoursquareCredentials.version.rawValue])
        APIClient().getData(request: imageRequest, mapResponseOnType: PlaceImageResponse.self, successHandler: { (response) in
            self.imageUrl.accept(response.response?.photos?.items?.first?.imageUrl)
        }) { (error) in

        }
    }
}
