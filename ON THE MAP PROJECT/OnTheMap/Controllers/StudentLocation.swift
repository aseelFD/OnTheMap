//
//  StudentLocation.swift
//  OnTheMap
//
//  Created by MAC on 12/06/1440 AH.
//  Copyright © 1440 MAC. All rights reserved.
//


import UIKit
import MapKit

class StudentLocation: UIViewController {
    
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


