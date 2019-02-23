//
//  Router+Location.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

extension Router {
	enum location: Endpoint {
		case list(limit: Int, skip: Int, orderBy: String)
		case submit(location: Location)

		var url: String {
			return "https://parse.udacity.com/parse/classes/StudentLocation"
		}

		var parameters: Data? {
			switch self {
			case .list(let limit, let skip, let orderBy):
				var params: [String: Any] = [:]
				params["limit"] = limit
				params["skip"] = skip
				params["order"] = "-\(orderBy)"
				return params.asUrlQuery
			case .submit(let location):
				return "{\"uniqueKey\": \"\(location.uniqueKey ?? "")\", \"firstName\": \"\(location.firstName ?? "")\", \"lastName\": \"\(location.lastName ?? "")\",\"mapString\": \"\(location.mapString ?? "")\", \"mediaURL\": \"\(location.mediaURL ?? "")\",\"latitude\": \(location.latitude ?? 0), \"longitude\": \(location.longitude ?? 0)}".data(using: .utf8)
			}
		}

		var headers: [String : String]? {
			var headers: [String: String] = [:]
			headers["X-Parse-Application-Id"] = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
			headers["X-Parse-REST-API-Key"] = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
			headers["Accept"] = "application/json"
			headers["Content-Type"] = "application/json"
			return headers
		}

		var method: HTTPMethod {
			switch self {
			case .list:
				return .get
			case .submit:
				return .post
			}
		}
	}
}
