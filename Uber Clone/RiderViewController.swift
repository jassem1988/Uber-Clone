//
//  RiderViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/26/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import MapKit

class RiderViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets

    @IBOutlet var map: MKMapView!
    
    @IBOutlet var callAnUberButton: UIButton!
    
    //Variables
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location Manager set up

        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    //MARK: - Location Managers Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate {
            
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            map.setRegion(region, animated: true)
            
            
            map.removeAnnotations(map.annotations) //Remove all previous annotations
            
            let annotation = MKPointAnnotation()
            
            annotation.coordinate = center
            
            annotation.title = "Your Location"
            
            map.addAnnotation(annotation)
            
        }
        
    }
    
    
    
    //MARK: - Actions Methods
    

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        
    }
    
    @IBAction func callUberPressed(_ sender: UIButton) {
        
    }
    

}
