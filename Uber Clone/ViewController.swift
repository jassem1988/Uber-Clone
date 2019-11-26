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
    
    @IBOutlet var topButton: UIButton!
    
    @IBOutlet var bottomButton: UIButton!
    
    @IBOutlet var riderLabel: UILabel!
    
    @IBOutlet var driverLabel: UILabel!
    
    //Variables
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func topButtonPressed(_ sender: UIButton) {
        
        if emailTextField.text == "" || passwordTextField.text == "" {
            
            displayAlert(title: "Missing Information", message: "You must provide both an Email and Password")
            
        } else {
            
            if let email = emailTextField.text {
                
                if let password = passwordTextField.text {
                    
                    if signUpMode {
                        //SIGN UP
                       
                        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                            
                            if error != nil {
                                
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                                
                            } else {
                                
                                print("Sign Up Success")
                                
                                self.performSegue(withIdentifier: "riderSegue", sender: nil)
                                
                            }
                            
                        }
                        
                        
                        
                    } else {
                        //LOG IN
                        
                        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                            
                            if error != nil {
                                
                                self.displayAlert(title: "Error", message: error!.localizedDescription)
                                
                            } else {
                                
                                print("Log In Success")
                                
                                self.performSegue(withIdentifier: "riderSegue", sender: nil)
                                
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    
    //MARK: - My Methods
    
    func displayAlert(title: String, message: String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    //MARK: - Button Actions
    
    @IBAction func bottomButtonPressed(_ sender: UIButton) {
        
        if signUpMode {
            
            topButton.setTitle("Log In", for: .normal)
            
            bottomButton.setTitle("Switch to Sign Up", for: .normal)
            
            riderLabel.isHidden = true
            
            driverLabel.isHidden = true
            
            riderDriverSwitch.isHidden = true
            
            signUpMode = false
            
        } else {
            
            topButton.setTitle("Sign Up", for: .normal)
            
            bottomButton.setTitle("Switch to Log In", for: .normal)
            
            riderLabel.isHidden = false
            
            driverLabel.isHidden = false
            
            riderDriverSwitch.isHidden = false
            
            signUpMode = true
            
        }
        
    }
    
    
}

