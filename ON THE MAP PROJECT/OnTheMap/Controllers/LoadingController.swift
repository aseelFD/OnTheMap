//
//  LoadingController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class LoadingController: UIViewController {

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
		providesPresentationContextTransitionStyle = true
		definesPresentationContext = true
		modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
		modalTransitionStyle = UIModalTransitionStyle.crossDissolve
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func loadView() {
		let ui = LoadingControllerView()
		view = ui
	}

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
