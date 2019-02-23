//
//  NewLocationMapViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import UIKit
import MapKit

class NewLocationMapViewController: UIViewController {

	@IBOutlet weak var mapView: MKMapView!

	var location: Location?

	override func viewDidLoad() {
		super.viewDidLoad()
		let coordinate = CLLocationCoordinate2D(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0)
		let annotation = MKPointAnnotation()
		annotation.coordinate = coordinate
		annotation.title = "\(location?.firstName ?? "") \(location?.lastName ?? "")"
		annotation.subtitle = location?.mediaURL
		mapView.addAnnotation(annotation)
	}

    /// ****************** OK FINISH BUTTON **************    
    @IBAction func OkFind(_ sender: Any) {
        Loading.show()
        location?.submit(success: { (_) in
            Loading.dismiss()
            self.dismiss(animated: true, completion: nil)
        }, failure: { (error) in
            Loading.dismiss()
            self.alert(title: "Error", message: error.localizedDescription, completion: nil)
        })
        
    }
    
    
    
    
    /// ****************** MAP VIEW SETTING **************
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        } else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
}


