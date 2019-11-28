//
//  AcceptRequestViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/28/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import MapKit

class AcceptRequestViewController: UIViewController {
    
    @IBOutlet var map: MKMapView!
    
    //Variables
    var requestLocation = CLLocationCoordinate2D()
    
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
        
    }
    

}
