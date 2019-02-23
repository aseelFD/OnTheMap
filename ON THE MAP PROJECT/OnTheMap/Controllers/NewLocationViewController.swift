//
//  NewLocationViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit
import CoreLocation

class NewLocationViewController: UIViewController {


//    @IBOutlet weak var textFieldLoacation: UITextField!
//    @IBOutlet weak var textFieldLink: TextFieldController!
    @IBOutlet weak var textFieldLocation: UITextField!
    @IBOutlet weak var textFieldLink: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
        
    @IBAction func FindLocation(_ sender: Any) {
        guard let location = textFieldLocation.text, !location.isEmpty, let link = textFieldLink.text, !link.isEmpty else {
            return
        }
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            guard let placemarks = placemarks, placemarks.count > 0 else {
                self.alert(title: "Error", message: "Couldn't find any location with the provided address, try to change the address", completion: nil)
                return
            }
            let newLocation = Location.init(createdAt: nil,
                                            updatedAt: nil,
                                            mapString: location,
                                            mediaURL: link,
                                            firstName: User.current?.firstName,
                                            lastName: User.current?.lastName,
                                            uniqueKey: User.current?.key,
                                            latitude: placemarks[0].location?.coordinate.latitude,
                                            longitude: placemarks[0].location?.coordinate.longitude)
            self.performSegue(withIdentifier: "ShowLocationMap", sender: newLocation)
        }
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? NewLocationMapViewController, let location = sender as? Location {
            vc.location = location
        }
    }
}

