//
//  NetworkService.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

class NetworkService {

	public func request<T: Decodable>(url: String,method: HTTPMethod,parameters: Data? = nil,headers: [String: String]? = nil,success: @escaping Success<T>,failure: @escaping Failure) {
		var request: URLRequest!
		if method == HTTPMethod.get {
			request = URLRequest(url: urlWith(url: url, parameters: parameters))
		} else {
			request = URLRequest(url: urlWith(url: url))
			request.httpBody = parameters
		}
		request.httpMethod = method.name
		request.allHTTPHeaderFields = headers
		request.httpShouldHandleCookies = false
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			DispatchQueue.main.async {
				guard let response = response as? HTTPURLResponse else {
					failure(ApiError.timeout)
					return
				}
                guard Array(200..<300).contains(response.statusCode) else {
					failure(ApiError(statusCode: response.statusCode))
					return
				}
				guard let data = data else {
					failure(ApiError.nilData)
					return
				}
				guard T.self != None.self else {
					success(None() as! T)
					return
				}
				do {
					let decoder = JSONDecoder()
					let object = try decoder.decode(T.self, from: data)
					success(object)
				} catch let error {
					if (error as NSError).code == 3840 || (error as NSError).code == 4864 {
						let data = data.subdata(in: 5..<data.count)
						do {
							let decoder = JSONDecoder()
							let object = try decoder.decode(T.self, from: data)
							success(object)
						} catch {
							print(error.localizedDescription)
							failure(ApiError.decodingFailed)
						}
					} else {
						print(error.localizedDescription)
						failure(ApiError.decodingFailed)
					}
				}
			}
		}.resume()
	}

	private func urlWith(url: String, parameters: Data? = nil) -> URL {
		guard let baseUrl = URL(string: url) else {
			fatalError("The BASE URL provided is not a valid url")
		}
		guard let parameters = parameters,
			let dictionary: Dictionary = NSKeyedUnarchiver.unarchiveObject(with: parameters) as? [String: Any] else {
			return baseUrl
		}
		var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
		components?.queryItems = dictionary.map { element in URLQueryItem(name: element.key, value: String(describing: element.value)) }
		guard let url = components?.url else {
			return baseUrl
		}
		return url
	}
}
