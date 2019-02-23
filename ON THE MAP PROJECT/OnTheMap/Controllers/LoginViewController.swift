//
//  LoginViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldPass: UITextField!
    
    

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		textFieldName.text = ""
		textFieldPass.text = ""
	}

	@IBAction func login(_ sender: UIButton) {
		Loading.show()
		User.login(username: textFieldName.text ?? "", password: textFieldPass.text ?? "", success: { (_) in
			Loading.dismiss()
			self.performSegue(withIdentifier: "SuccessfulLogin", sender: nil)
		}) { (error) in
			Loading.dismiss()
			self.alert(title: "Error", message: "Wrong Email/Password", completion: nil)
		}
	}

    
    /// ****************** UDACITY SIGNUP BUTTON **************
	@IBAction func signup(_ sender: Any) {
        guard let url = URL(string: "https://auth.udacity.com/sign-up?") else { return }
        UIApplication.shared.open(url)
	}
    
    
    /// ****************** ENABLE RETURN KEY ON TEXTFEILD **************
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
