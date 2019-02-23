//
//  LocationViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    
    /// ****************** STUDENTS' LOCATION ARRAY LIST **************
	var list: [Location]?

	override func viewDidLoad() {
		super.viewDidLoad()
		reloadData()
		let addButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(showAddNewLocation(_:)))
		let reloadButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(reloadData(_:)))
		let logoutButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout(_:)))
		navigationItem.leftBarButtonItem = logoutButton
		navigationItem.rightBarButtonItems = [reloadButton, addButton]
	}

	@objc private func showAddNewLocation(_ sender: UIBarButtonItem) {
		guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewLocationViewController") as? NewLocationViewController else { return }
		let nv = UINavigationController(rootViewController: vc)
		present(nv, animated: true, completion: nil)
	}

	@objc private func reloadData(_ sender: UIBarButtonItem) {
		reloadData(force: true)
	}

	@objc private func logout(_ sender: UIBarButtonItem) {
		Loading.show()
		User.logout(success: { (_) in
			self.dismiss(animated: true, completion: {
				self.dismiss(animated: true, completion: nil)
			})
		}) { (error) in
			Loading.dismiss()
			self.alert(title: "Error", message: error.localizedDescription, completion: nil)
		}
	}

	private func reloadData(force: Bool = false) {
		Loading.show()
		Location.list(new: force, success: { (locations) in
			Loading.dismiss()
			self.list = locations
		}) { (error) in
			Loading.dismiss()
			self.alert(title: "Error", message: error.localizedDescription, completion: nil)
		}
	}
}
