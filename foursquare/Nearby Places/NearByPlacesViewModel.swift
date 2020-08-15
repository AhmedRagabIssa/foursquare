//
//  NearByPlacesViewModel.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NearByPlacesViewModel {

    private(set) var loaderSate: BehaviorRelay<LoaderState> = BehaviorRelay(value: .shown)
    var venues: BehaviorRelay<[Venue]> = BehaviorRelay(value: [])

    func getNearByPlaces() {
        let placesRequest = SimpleGetRequest(url        : APIs.forsquarePlaces.rawValue,
                                             parameters : ["ll"            : "40.7,-74", // TODO: - change the static location to be dynamic
                                                           "client_id"     : FoursquareCredentials.clientId.rawValue,
                                                           "client_secret" : FoursquareCredentials.clientSecret.rawValue,
                                                           "v"             : FoursquareCredentials.version.rawValue])

        APIClient().getData(request: placesRequest, mapResponseOnType: FoursquareResponse.self, successHandler: { (response) in
            print("sucess")
            self.loaderSate.accept(.hidden)
            self.venues.accept(response.response?.venues ?? [])
        }) { (error) in
            print("failure")
        }
    }
}
