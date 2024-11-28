//
//  MapLocationViewController.swift
//  Idealista
//
//  Created by Conrado Capilla García on 25/11/24.
//

import UIKit
import MapKit


protocol MapLocationViewProtocol: AnyObject {
    var presenter: MapLocationPresenterProtocol? { get set }
}

class MapLocationViewController: BaseViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var mapView: MKMapView!
    
    var latitude: CGFloat = 0.0
    var longitude: CGFloat = 0.0
    
    var presenter: MapLocationPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "My location"
        annotation.subtitle = "Example location"
        mapView.addAnnotation(annotation)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
    }

}

extension MapLocationViewController: MapLocationViewProtocol {
    
}
