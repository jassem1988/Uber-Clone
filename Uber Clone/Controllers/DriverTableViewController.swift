//
//  DriverTableViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/27/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import MapKit

class DriverTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    //Variables
    var rideRequests : [DataSnapshot] = []
    
    var locationManager = CLLocationManager()
    
    var driverLocation = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Location Manager set up
        
        locationManager.delegate = self
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()
        
        //Search for ride requests
        Database.database().reference().child("RiderRequests").observe(.childAdded) { (snapshot) in
            
            self.rideRequests.append(snapshot)
            
            self.tableView.reloadData()
            
        }
        
        //Create a Timer to update riders locations automaticly
        
        Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (timer) in
            
            self.tableView.reloadData()
            
        }
        
        
    }
    
    
    //MARK: - Location Manager Methods
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let coord = manager.location?.coordinate {
            
            driverLocation = coord
            
        }
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rideRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "riderRequestCell", for: indexPath)
        
        let snapshot = rideRequests[indexPath.row]
        
        if let rideRequestsDictionary = snapshot.value as? [String : AnyObject] {
            
            if let email = rideRequestsDictionary["email"] as? String {
                
                if let lat = rideRequestsDictionary["lat"] as? Double {
                    
                    if let lon = rideRequestsDictionary["lon"] as? Double {
                        
                        let driverCLLocation = CLLocation(latitude: driverLocation.latitude, longitude: driverLocation.longitude)
                        
                        let riderCLLocation = CLLocation(latitude: lat, longitude: lon)
                        
                        let distance = driverCLLocation.distance(from: riderCLLocation) / 1000
                        
                        let roundedDistance = round(distance * 100) / 100
                        
                        cell.textLabel?.text = "\(email) - \(roundedDistance)km away"
                        
                    }
                    
                }
                
            }
            
        }
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snapshot = rideRequests[indexPath.row]
        
        performSegue(withIdentifier: "acceptSegue", sender: snapshot)
        
    }
    
    
    //MARK: - My Methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let acceptVC = segue.destination as? AcceptRequestViewController {
            
            if let snapshot = sender as? DataSnapshot {
                
                if let rideRequestsDictionary = snapshot.value as? [String : AnyObject] {
                    
                    if let email = rideRequestsDictionary["email"] as? String {
                        
                        if let lat = rideRequestsDictionary["lat"] as? Double {
                            
                            if let lon = rideRequestsDictionary["lon"] as? Double {
                                
                                acceptVC.requestEmail = email
                                
                                let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                
                                acceptVC.requestLocation = location
                                
                                acceptVC.driverLocation = driverLocation
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    
    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        try? Auth.auth().signOut()
        
        navigationController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    
}
