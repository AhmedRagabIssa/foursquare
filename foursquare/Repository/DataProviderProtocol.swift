//
//  DataProviderProtocol.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    func getData<ResponseType: Codable> (request: RequestProtocol, mapResponseOnType: ResponseType.Type, successHandler: @escaping (ResponseType) -> Void, failureHandler: @escaping (Error) -> Void)
}
