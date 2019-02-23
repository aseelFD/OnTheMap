//
//  User.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation

struct User: Codable {
	private(set) static var current: User?

	let key: String?
	let lastName: String?
	let firstName: String?
	let nickname: String?
	var sessionId: String?

	enum CodingKeys: String, CodingKey {
		case key = "key"
		case lastName = "last_name"
		case firstName = "first_name"
		case nickname = "nickname"
	}

	static func login(username: String, password: String, success: @escaping Success<None>, failure: @escaping Failure) {
		_login(username: username, password: password, success: { (loginResponse) in
			guard let id = loginResponse.account?.key else {
				failure(ApiError.serverError)
				return
			}
			info(id: id, success: { (user) in
				User.current = user
				User.current?.sessionId = loginResponse.session?.id
				success(None())
			}, failure: failure)
		}, failure: failure)
	}

	private static func _login(username: String, password: String, success: @escaping Success<LoginResponse>, failure: @escaping Failure) {
		Router.user.login(username: username, password: password).request(success: success, failure: failure)
	}

	static func info(id: String, success: @escaping Success<User>, failure: @escaping Failure) {
		Router.user.info(id: id).request(success: success, failure: failure)
	}

	static func logout(success: @escaping Success<None>, failure: @escaping Failure) {
		Router.user.logout.request(success: success, failure: failure)
	}
}

fileprivate struct LoginResponse: Codable {
	let session: UserSession?
	let account: UserAccount?
}

fileprivate struct UserSession: Codable {
	let id: String
	let expiration: String
}

fileprivate struct UserAccount: Codable {
	let key: String
	let registered: Bool
}
