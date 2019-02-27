//
//  SignUpViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 2/10/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class SignUpViewController: UIViewController {

    @IBOutlet var emailBox: UITextField!
    @IBOutlet var passwordBox: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        Auth.auth().createUser(withEmail: (emailBox.text!.trimmingCharacters(in: .whitespaces)), password: passwordBox.text!){ (user, error) in
                if error == nil {
                    _ = self.navigationController?.popToRootViewController(animated: false)//return to login page
                    let alertController = UIAlertController(title: "Success", message: "Account created!", preferredStyle: .alert)
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
