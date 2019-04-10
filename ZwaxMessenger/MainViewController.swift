//
//  MainViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 2/24/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class MainViewController: UIViewController {

    
    @IBOutlet var newEmailBox: UITextField!
    @IBAction func changeEmailButton(_ sender: Any) {
        let currentUser = Auth.auth().currentUser
        
        currentUser?.updateEmail(to: newEmailBox.text!) { error in
            if let error = error {
                print(error)
            } else{
                let alertController = UIAlertController(title: "Email Changed", message: "Sign in with " + self.newEmailBox.text! + " from now on.", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func userLogOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            _ = self.navigationController?.popToRootViewController(animated: true)
            let alertController = UIAlertController(title: "Success", message: "Logged out!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    @IBAction func logOut(_ sender: UIButton) {
        userLogOut()
    }
    override func viewWillDisappear(_ animated: Bool) {
        //userLogOut()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //???
        // Do any additional setup after loading the view.
    }
    @IBAction func myChannels(_ sender: UIButton) {
        self.performSegue(withIdentifier: "channels", sender: self)
    }
    @IBAction func myChats(_ sender: UIButton) {
        self.performSegue(withIdentifier: "chats", sender: self)
    }
    @IBAction func newMessage(_ sender: UIButton) {
        self.performSegue(withIdentifier: "newmessage", sender: self)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
