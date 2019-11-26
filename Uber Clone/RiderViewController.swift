//
//  RiderViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/26/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth

class RiderViewController: UIViewController, CLLocationManagerDelegate {
    
    //Outlets
    
    @IBOutlet var map: MKMapView!
    
    @IBOutlet var callAnUberButton: UIButton!
    
    //Variables
    
    var locationManager = CLLocationManager()
    
    var userLocation = CLLocationCoordinate2D()
    
    var uberHasBeenCalled = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location Manager set up
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        //Make sure the cancel uber is available when loged out
        
        if let email = Auth.auth().currentUser?.email {
            
            Database.database().reference().child("RiderRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded) { (snapshot) in
                
                self.uberHasBeenCalled = true
                
                self.callAnUberButton.setTitle("Cancel Uber", for: .normal)
                
                Database.database().reference().child("RiderRequests").removeAllObservers()
                
            }
            
        }
        
        
    }
    
    
    //MARK: - Location Managers Methods
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate {
            
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            
            userLocation = center
            
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
        
        try? Auth.auth().signOut()
        
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func callUberPressed(_ sender: UIButton) {
        
        if let email = Auth.auth().currentUser?.email {
            
            if uberHasBeenCalled {
                
                uberHasBeenCalled = false
                
                callAnUberButton.setTitle("Call an Uber", for: .normal)
                
                Database.database().reference().child("RiderRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded) { (snapshot) in
                    
                    snapshot.ref.removeValue()
                    
                    Database.database().reference().child("RiderRequests").removeAllObservers()
                    
                }
                
                
            } else {
                
                let rideRequestDictionary : [String: Any] = ["email" : email, "lat" : userLocation.latitude, "lon" : userLocation.longitude]
                
                Database.database().reference().child("RiderRequests").childByAutoId().setValue(rideRequestDictionary)
                
                uberHasBeenCalled = true
                
                callAnUberButton.setTitle("Cancel Uber", for: .normal)
                
            }
            
            
            
        }
        
    }
    
    
}
