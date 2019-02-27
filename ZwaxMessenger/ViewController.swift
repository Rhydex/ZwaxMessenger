//
//  ViewController.swift
//  ZwaxMessenger
//
//  Created by Ryden Neal on 2/7/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var usernameSignin: UITextField!
    @IBOutlet weak var passwordSignin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    } 
    
    @IBAction func resetPassword(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: (usernameSignin.text?.trimmingCharacters(in: .whitespacesAndNewlines))!) { error in
            let alertController = UIAlertController(title: "Email sent", message: "Check you inbox to reset your password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func loginUser(_ sender: Any) {
        Auth.auth().signIn(withEmail: (usernameSignin.text?.trimmingCharacters(in: .whitespacesAndNewlines))!, password: passwordSignin.text!) { (user, error) in
            if error == nil{
                //perform segue
                self.performSegue(withIdentifier: "loggedIn", sender: self)
            
                let alertController = UIAlertController(title: "Success", message: "Logged In Successfully!", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

