//
//  Endpoint.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation


protocol Endpoint {
	var url: String { get }
	var parameters: Data? { get }
	var headers: [String: String]? { get }
	var method: HTTPMethod { get }
	func request<T: Decodable>(success: @escaping Success<T>, failure: @escaping Failure)
}

extension Endpoint {
	func request<T: Decodable>(success: @escaping Success<T>, failure: @escaping Failure) {
		NetworkService().request(url: url, method: method, parameters: parameters, headers: headers, success: success, failure: failure)
	}
}
