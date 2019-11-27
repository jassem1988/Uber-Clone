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

class DriverTableViewController: UITableViewController {
    
    //Variables
    var rideRequests : [DataSnapshot] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Search for ride requests
        Database.database().reference().child("RiderRequests").observe(.childAdded) { (snapshot) in
            
            self.rideRequests.append(snapshot)
            
            self.tableView.reloadData()
            
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
                
                cell.textLabel?.text = email
                
            }
            
        }
        
        
        
        return cell
        
    }

    @IBAction func logoutPressed(_ sender: UIBarButtonItem) {
        
        try? Auth.auth().signOut()
        
        navigationController?.dismiss(animated: true, completion: nil)
        
        
    }
    

}
