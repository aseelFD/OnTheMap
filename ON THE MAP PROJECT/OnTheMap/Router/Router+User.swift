//
//  Router+User.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

extension Router {
	enum user: Endpoint {
		case login(username: String, password: String)
		case logout
		case info(id: String)

		var baseUrl: String {
			return "https://onthemap-api.udacity.com/v1/"
		}

		var url: String {
			switch self {
			case .login:
				return baseUrl + "session"
			case .logout:
				return baseUrl + "session"
			case .info(let id):
				return baseUrl + "users/\(id)"
			}
		}

		var parameters: Data? {
			switch self {
			case .login(let username, let password):
				return "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
			case .logout, .info:
				return nil
			}
		}

		var headers: [String: String]? {
			var headers: [String: String] = [:]
			headers["X-Parse-Application-Id"] = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
			headers["X-Parse-REST-API-Key"] = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
			headers["Accept"] = "application/json"
			headers["Content-Type"] = "application/json"
			switch self {
			case .logout:
				var xsrfCookie: HTTPCookie? = nil
				let sharedCookieStorage = HTTPCookieStorage.shared
				for cookie in sharedCookieStorage.cookies! {
					if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
				}
				if let xsrfCookie = xsrfCookie {
					headers["X-XSRF-TOKEN"] = xsrfCookie.value
				}
			default: break
			}
			return headers
		}

		var method: HTTPMethod {
			switch self {
			case .login:
				return .post
			case .logout:
				return .delete
			case .info:
				return .get
			}
		}
	}
}
