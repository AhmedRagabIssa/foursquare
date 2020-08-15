//
//  RequestProtocol.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/15/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation
import Alamofire

public protocol RequestProtocol {
    var url: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var parameters: Parameters { get }
}

extension RequestProtocol {
    var method: HTTPMethod { return .get }
    var headers: HTTPHeaders { return ["Content-Type" : "application/json"]}
    var parameters: Parameters { return [:] }
}

class SimpleGetRequest: RequestProtocol {
    var url: String

    required init(url: String) {
        self.url = url
    }
}
