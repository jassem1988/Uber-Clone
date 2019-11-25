//
//  ViewController.swift
//  Uber Clone
//
//  Created by Jassem Al-Buloushi on 11/25/19.
//  Copyright © 2019 Jassem Al-Buloushi. All rights reserved.
//

import UIKit
import FirebaseAuth


class ViewController: UIViewController {
    
    //Outlets
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    @IBOutlet var riderDriverSwitch: UISwitch!
    
    @IBOutlet var signUpOutlet: UIButton!
    
    @IBOutlet var loginOutlet: UIButton!
    
    @IBOutlet var riderLabel: UILabel!
    
    @IBOutlet var driverLabel: UILabel!
    
    //Variables
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signUpPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        
        if signUpMode {
            
            signUpOutlet.setTitle("Log In", for: .normal)
            
            loginOutlet.setTitle("Switch to Sign Up", for: .normal)
            
            riderLabel.isHidden = true
            
            driverLabel.isHidden = true
            
            riderDriverSwitch.isHidden = true
            
            signUpMode = false
            
        } else {
            
            signUpOutlet.setTitle("Sign Up", for: .normal)
            
            loginOutlet.setTitle("Switch to Log In", for: .normal)
            
            riderLabel.isHidden = false
            
            driverLabel.isHidden = false
            
            riderDriverSwitch.isHidden = false
            
            signUpMode = true
            
        }
        
    }
    
    
}

