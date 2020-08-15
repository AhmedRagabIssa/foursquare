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
    private(set) var locationUpdateMode: BehaviorRelay<LocationUpdateMode>

    private let disposeBag = DisposeBag()
    private var locationManager = LocationManager()
    private var userLocation: LocationManager.Location?
    private var didReciveLocationUpdate: ((LocationManager.Location?, LocationError?) -> Void)?

    var venuesCellsViewModels: BehaviorRelay<[PlaceCellViewModel]> = BehaviorRelay(value: [])

    init() {
        locationUpdateMode = BehaviorRelay(value: LocationUpdateMode.getLastLocationUpdateMode())
        observeOnLocarionUpdateMode()
        initDidReciveLocationUpdate()
        locationManager.didReciveLocationUpdate = didReciveLocationUpdate
        locationManager.startUpdatingLocation()
    }

    func getNearByPlaces(for location: LocationManager.Location) {
        let placesRequest = SimpleGetRequest(url        : APIs.forsquarePlaces.rawValue,
                                             parameters : ["ll"            : "\(location.latitude),\(location.longitude)",
                                                           "client_id"     : FoursquareCredentials.clientId.rawValue,
                                                           "client_secret" : FoursquareCredentials.clientSecret.rawValue,
                                                           "v"             : FoursquareCredentials.version.rawValue])

        APIClient().getData(request: placesRequest, mapResponseOnType: FoursquareResponse.self, successHandler: { (response) in
            print("sucess")
            self.loaderSate.accept(.hidden)
            var venuesViewModels: [PlaceCellViewModel] = []
            response.response?.venues?.forEach({ venue in
                venuesViewModels.append(PlaceCellViewModel(venue: venue))
            })
            self.venuesCellsViewModels.accept(venuesViewModels)

            if (response.response?.venues?.isEmpty ?? true) {
                self.errorState.accept(.shown(#imageLiteral(resourceName: "alert"), "No data found !!"))
            }
        }) { (error) in
            print("failure")
            self.loaderSate.accept(.hidden)
            self.errorState.accept(.shown(#imageLiteral(resourceName: "error"), "Something went wrong !!"))
        }
    }

    private func initDidReciveLocationUpdate() {
        didReciveLocationUpdate = { [weak self] location, error in
            self?.userLocation = location
            print("location: \(location?.latitude ?? 0), \(location?.longitude ?? 0). error: \(error?.category ?? "")")
            // handle the location errors
            if let error = error {
                self?.loaderSate.accept(.hidden)
                self?.errorState.accept(.shown(#imageLiteral(resourceName: "error"), error.reason))
                return
            }
            self?.errorState.accept(.hidden)
            if let location = location {
                self?.getNearByPlaces(for: location)
            } else {
                self?.loaderSate.accept(.hidden)
                self?.errorState.accept(.shown(#imageLiteral(resourceName: "error"), "Something went wrong while getting your location !!"))
            }
        }
    }

    private func observeOnLocarionUpdateMode() {
        locationUpdateMode.asObservable().subscribe(onNext: { [unowned self] mode in
            UserDefaults.standard.setValue(mode == .realtime, forKey: UserDefaultsKeys.isLocationUpdateModeRealtime.rawValue)
            switch mode {
            case .single: self.locationManager.stopMonitoringSignificantLocationChanges()
            case .realtime: self.locationManager.startMonitoringSignificantLocationChanges()
            }
        }).disposed(by: disposeBag)
    }

    func toggleLocationUpdateMode() {
        if locationUpdateMode.value == .realtime {
            locationUpdateMode.accept(.single)
        } else {
            locationUpdateMode.accept(.realtime)
        }
    }
}

enum LocationUpdateMode {
    case single
    case realtime

    static func getLastLocationUpdateMode() -> LocationUpdateMode {
        let isRealtime: Bool = UserDefaults.standard.value(forKey: UserDefaultsKeys.isLocationUpdateModeRealtime.rawValue) as? Bool ?? true
        return isRealtime ? .realtime : .single
    }
}
