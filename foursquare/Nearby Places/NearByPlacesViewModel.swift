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
    private(set) var errorState: BehaviorRelay<ErrorState> = BehaviorRelay(value: .hidden)
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

            if (response.response?.venues?.isEmpty ?? true) {
                self.errorState.accept(.shown(#imageLiteral(resourceName: "alert"), "No data found !!"))
            }
        }) { (error) in
            print("failure")
            self.loaderSate.accept(.hidden)
            self.errorState.accept(.shown(#imageLiteral(resourceName: "error"), "Something went wrong !!"))
        }
    }
}
