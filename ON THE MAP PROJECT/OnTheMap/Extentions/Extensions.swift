//
//  Extensions.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//
import UIKit

extension UIViewController {
    func alert(title: String?, message: String? = nil, completion: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
}
extension Dictionary where Key == String {
	var asUrlQuery: Data {
		return try! NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
	}
}


