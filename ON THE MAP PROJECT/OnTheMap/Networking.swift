//
//  Networking.swift
//  OnTheMap
//
//  Created by Qutaibah Essa on 07/02/2019.
//  Copyright © 2019 qutaibah. All rights reserved.
//

import Foundation
//
//class API {
//	static let shared = API()
//	private init() {}
//
//	var key: String = ""
//	var id: String = ""
//
//	func login(username: String, password: String, completion: @escaping (_ error: String?) -> Void) {
//		let params = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
//		let url = "https://onthemap-api.udacity.com/v1/session"
//		request(url: url, method: "POST", parameters: params) { (status, data) in
//			guard status else {
//				completion("incorrect username or password")
//				return
//			}
//			do {
//				let newData = data?.subdata(in: 5..<data!.count)
//				let data = try JSONSerialization.jsonObject(with: newData!, options: .allowFragments)  as? [String: Any]
//				let sessionDict = data?["session"] as? [String: Any]
//				let accountDict = data?["account"] as? [String: Any]
//				self.key = accountDict?["key"] as? String ?? ""
//				print(self.key)
//				self.id = sessionDict?["id"] as? String ?? ""
//				completion(nil)
//			} catch {
//				completion("couldn't serialize the object")
//			}
//		}
//	}
//
//	func logout(completion: @escaping (_ status: Bool) -> Void) {
//
//	}
//
//	func getLocations(limit: Int = 100, skip: Int = 0, orderBy: String = "updatedAt", completion: @escaping ([StudentLocation]?) -> Void) {
//		let url = "https://parse.udacity.com/parse/classes/StudentLocation?limit=\(limit)&skip=\(skip)&order=-\(orderBy)"
//
//		request(url: url, method: "GET") { (status, data) in
//			guard status else {
//				completion(nil)
//				return
//			}
//			do {
//				let location = try JSONDecoder().decode(StudentLocationResult.self, from: data!)
//				completion(location.results)
//			} catch {
//				completion(nil)
//			}
//		}
//	}
//
//	func getStudentsLocations(limit: Int = 100, skip: Int = 0, orderBy: String = "updatedAt", completion: @escaping (_ locations: [StudentLocation]?) -> Void) {
//		let url = "https://parse.udacity.com/parse/classes/StudentLocation?limit=\(limit)&skip=\(skip)&order=-\(orderBy)"
//		let method = "GET"
//		request(url: url, method: method, completion: completion)
//	}
//
//
//	func getUserInfo(completion: @escaping (_ status: Bool) -> Void) {
//		let url = "https://onthemap-api.udacity.com/v1/users/\(self.key)"
//		request(url: url, method: "GET") { (status, data) in
//			guard status else {
//				return
//			}
//			let newData = data?.subdata(in: 5..<data!.count)
//			do {
//				let object = try JSONSerialization.jsonObject(with: newData!, options: [])
//				completion(true)
//			} catch {
//				completion(false)
//			}
//		}
//	}
//
//	func postLocation(location: StudentLocation, completion: @escaping (_ status: Bool) -> Void) {
//		let url = "https://parse.udacity.com/parse/classes/StudentLocation"
//		var params: Data?
//		do {
//			params = try JSONEncoder().encode(location)
//		} catch {
//			print(error)
//		}
//		print(String(data: params!, encoding: .utf8))
//		request(url: url, method: "POST", parameters: params) { (status, data) in
//			guard status else {
//				completion(false)
//				return
//			}
//			do {
//				let data = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
//				completion(true)
//			} catch {
//				completion(false)
//			}
//		}
//	}
//
//	func request<SomeType: Decodable>(url: String, method: String, parameters: Data? = nil, completion: @escaping (_ object: SomeType?) -> Void) {
//		var request = URLRequest(url: URL(string: url)!)
//		request.httpMethod = method
//		request.httpBody = parameters
//		request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
//		request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
//		request.addValue("application/json", forHTTPHeaderField: "Accept")
//		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//
//		URLSession.shared.dataTask(with: request) { (data, response, error) in
//			guard let statusCode = (response as? HTTPURLResponse)?.statusCode,
//				let data = data,
//				(statusCode > 199 && statusCode < 300) else {
//					completion(nil)
//					return
//			}
//			do {
//				let result = try JSONDecoder().decode(SomeType.self, from: data)
//				completion(result)
//			} catch {
//				if (error as NSError).code == 3840 || (error as NSError).code == 4864 {
//					let data = data.subdata(in: 5..<data.count)
//					do {
//						let result = try JSONDecoder().decode(SomeType.self, from: data)
//						completion(result)
//					} catch {
//						completion(nil)
//					}
//				} else {
//					print(error)
//					completion(nil)
//				}
//			}
//			}.resume()
//	}
//}
//
//
