//
//  PlaceImageResponse.swift
//  foursquare
//
//  Created by Ahmed Ragab Issa on 8/16/20.
//  Copyright © 2020 Ahmed Ragab Issa. All rights reserved.
//

import Foundation

// MARK: - PlaceImageResponse
struct PlaceImageResponse: Codable {
    let response: ResponsePhotos?
}

// MARK: - Response
struct ResponsePhotos: Codable {
    let photos: Photos?
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int?
    let items: [Item]?
}

// MARK: - Item
struct Item: Codable {
    let prefix: String?
    let suffix: String?

    var imageUrl: String? {
        if let pre = prefix, let suf = suffix {
            return "\(pre)100\(suf)"
        }
        return nil
    }
}

