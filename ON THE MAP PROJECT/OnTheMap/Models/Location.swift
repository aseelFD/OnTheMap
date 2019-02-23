//
//  Location.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

struct Location: Codable {
	static var lastLoaded: [Location]?

	let createdAt: String?
	let updatedAt: String?
	var mapString: String?
	var mediaURL: String?
	var firstName: String?
	var lastName: String?
	var uniqueKey: String?
	var latitude: Double?
	var longitude: Double?
    
    static func list(new: Bool = false, limit: Int = 100, skip: Int = 0, orderBy: String = "updatedAt", success: @escaping Success<[Location]>, failure: @escaping Failure) {
        if !new, let locations = Location.lastLoaded {
            success(locations)
            return
        }
        _list(limit: limit, skip: skip, orderBy: orderBy, success: { (locationResponse) in
            guard let list = locationResponse.results else {
                failure(ApiError.serverError)
                return
            }
            success(list)
        }, failure: failure)
    }
    
    private static func _list(limit: Int, skip: Int, orderBy: String,success: @escaping Success<LocationResponse>, failure: @escaping Failure) {
        Router.location.list(limit: limit, skip: skip, orderBy: orderBy).request(success: success, failure: failure)
    }
    
    func submit(success: @escaping Success<None>, failure: @escaping Failure) {
        Router.location.submit(location: self).request(success: success, failure: failure)
    }

}

fileprivate struct LocationResponse: Codable {
	let results: [Location]?
}

