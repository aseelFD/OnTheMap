//
//  Response.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

typealias Success<T: Decodable> = (T) -> Void

typealias Failure = (Error) -> Void

struct None: Codable {}

enum HTTPMethod {
	case get
	case post
	case put
	case delete

	var name: String {
		switch self {
		case .get:
			return "GET"
		case .post:
			return "POST"
		case .put:
			return "PUT"
		case .delete:
			return "DELETE"
		}
	}
}

enum ApiError: Error {
	case timeout
	case serverError
	case notFound
	case unauthorized
	case badRequest
	case unprocessableEntity
	case decodingFailed
	case nilData
	case parametersShouldHaveValue
	case unknown

	init(statusCode: Int) {
		switch statusCode {
		case 400:
			self = .badRequest
		case 401:
			self = .unauthorized
		case 404:
			self = .notFound
		case 422:
			self = .unprocessableEntity
		case 500..<600:
			self = .serverError
		default:
			self = .unknown
		}
	}

	var localizedDescription: String {
		switch self {
		case .timeout:
			return "The request has timed out, try again"
		case .serverError:
			return "The server is not responding"
		case .notFound:
			return "We couldn't find any match for your request"
		case .unauthorized:
			return "You are not authorized please login first"
		case .badRequest:
			return "The entered values are incorrect"
		case .unprocessableEntity:
			return "The entered values are incorrect"
		case .decodingFailed:
			return "The server has updates that you don't have, please update the app"
		case .nilData:
			return "The server is not responding"
		case .parametersShouldHaveValue:
			return "The entered values are incorrect"
		case .unknown:
			return "Something wiered is going on, please try again"
		}
	}
}

extension ApiError: LocalizedError {
	public var errorDescription: String? {
		return self.localizedDescription
	}
}
