//
//  AcceptRequestViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/28/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase

class AcceptRequestViewController: UIViewController {
    
    @IBOutlet var map: MKMapView!
    
    //Variables
    var requestLocation = CLLocationCoordinate2D()
    
    var driverLocation = CLLocationCoordinate2D()
    
    var requestEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Map set up
        let region = MKCoordinateRegion(center: requestLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        map.setRegion(region, animated: false)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = requestLocation

        annotation.title = requestEmail
        
        map.addAnnotation(annotation)
        
    }
    

    @IBAction func acceptPressed(_ sender: UIButton) {
        
        //Update the ride request
        Database.database().reference().child("RiderRequests").queryOrdered(byChild: "email").queryEqual(toValue: requestEmail).observe(.childAdded) { (snapshot) in
            
            snapshot.ref.updateChildValues(["driverLat" : self.driverLocation.latitude, "driverLon" : self.driverLocation.longitude])
            
            Database.database().reference().child("RiderRequests").removeAllObservers()
            
        }
        
        //Give directions
        let requestCLLocation = CLLocation(latitude: requestLocation.latitude, longitude: requestLocation.longitude)
        
        CLGeocoder().reverseGeocodeLocation(requestCLLocation) { (placemarks, error) in
            
            if let placemarks = placemarks {
                
                if placemarks.count > 0 {
                    
                    let placeMark = MKPlacemark(placemark: placemarks[0])
                    
                    let mapItem = MKMapItem(placemark: placeMark)
                    
                    mapItem.name = self.requestEmail
                    
                    let options = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                    
                    mapItem.openInMaps(launchOptions: options)
                    
                    
                    
                }
                
            }
            
        }
        
    }
    

}
