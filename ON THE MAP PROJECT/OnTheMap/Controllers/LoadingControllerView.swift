//
//  LoadingControllerView.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class LoadingControllerView: UIView {

	lazy var view: UIView = {
		let v = UIView()
		v.layer.cornerRadius = 8
		v.layer.masksToBounds = true
		v.backgroundColor = .black
		v.translatesAutoresizingMaskIntoConstraints = false
		return v
	}()

	lazy var indicator: UIActivityIndicatorView = {
		let ind = UIActivityIndicatorView(style: .whiteLarge)
		ind.color = .white
		ind.startAnimating()
		ind.translatesAutoresizingMaskIntoConstraints = false
		return ind
	}()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.black.withAlphaComponent(0.15)
		view.addSubview(indicator)
		addSubview(view)

		view.heightAnchor.constraint(equalToConstant: 100).isActive = true
		view.widthAnchor.constraint(equalToConstant: 100).isActive = true
		view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
		view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

		indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
