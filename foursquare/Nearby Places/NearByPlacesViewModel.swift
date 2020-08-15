//
//  NearByPlacesViewModel.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation

class NearByPlacesViewModel {

    var venues: [Venue] = []

    func getNearByPlaces() {
        let placesRequest = SimpleGetRequest(url        : APIs.forsquarePlaces.rawValue,
                                             parameters : ["ll"            : "40.7,-74", // TODO: - change the static location to be dynamic
                                                           "client_id"     : FoursquareCredentials.clientId.rawValue,
                                                           "client_secret" : FoursquareCredentials.clientSecret.rawValue,
                                                           "v"             : FoursquareCredentials.version.rawValue])

        APIClient().getData(request: placesRequest, mapResponseOnType: FoursquareResponse.self, successHandler: { (response) in
            print("sucess")
            self.venues = response.response?.venues ?? []
        }) { (error) in
            print("failure")
        }
    }
}
