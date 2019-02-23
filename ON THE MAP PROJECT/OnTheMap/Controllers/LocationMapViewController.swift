//
//  LocationMapViewController.swift
//  OnTheMap
//
//  Created by MAC on 20/05/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//

import Foundation
import MapKit
import SafariServices

class LocationMapViewController: LocationViewController, MKMapViewDelegate {

	@IBOutlet weak var mapView: MKMapView!

	override var list: [Location]? {
		didSet {
			updateMapWithList()
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		title = "Map"
        mapView.delegate = self 
	}

	func updateMapWithList() {
		mapView.removeAnnotations(mapView.annotations)
		var locationAnnotations: [MKPointAnnotation] = []
		for location in (self.list ?? [])
			where location.latitude != nil && location.longitude != nil {
			let coordinate = CLLocationCoordinate2D(latitude: location.latitude ?? 0, longitude: location.longitude ?? 0)
			let annotation = MKPointAnnotation()
			annotation.coordinate = coordinate
			annotation.title = "\(location.firstName ?? "") \(location.lastName ?? "")"
			annotation.subtitle = location.mediaURL
			locationAnnotations.append(annotation)
		}
		mapView.addAnnotations(locationAnnotations)
	}
    
    
    
    
    
    /// ****************** MAPVIEW SETTINGS **************
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
    
    /// ****************** URL IN MAPVIEW SETTINGS **************
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            guard let urlString = view.annotation?.subtitle,
                let url = URL(string: urlString ?? ""),
                UIApplication.shared.canOpenURL(url) else {
                    let alert = UIAlertController(title: "Invalid URL", message: "The location you selected has an invalid URL", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                        return
                    }))
                    self.present(alert, animated: true, completion: nil)
                    return
            }
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }
    
}
