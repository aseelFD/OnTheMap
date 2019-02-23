//
//  Loading.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class Loading {
	private static var controller = LoadingController()
	private init() {}

	static func show() {
		guard !(UIApplication.shared.topMostViewController() is LoadingController) else { return }
		UIApplication.shared.topMostViewController()?.present(controller, animated: true, completion: nil)
	}

	static func dismiss() {
		controller.dismiss(animated: true, completion: nil)
	}
}

extension UIViewController {
	func topMostViewController() -> UIViewController {
		if self.presentedViewController == nil {
			return self
		}
		if let tab = self.presentedViewController as? UITabBarController {
			if let selectedTab = tab.selectedViewController {
				return tab
			}
			return tab.topMostViewController()
		}
		if let navigation = self.presentedViewController as? UINavigationController {
			return navigation.visibleViewController!.topMostViewController()
		}
		return self.presentedViewController!.topMostViewController()
	}
}

extension UIApplication {
	func topMostViewController() -> UIViewController? {
		return self.keyWindow?.rootViewController?.topMostViewController()
	}
}

