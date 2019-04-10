//
//  HistoryViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 3/10/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MessageViewController: UIViewController {

    @IBOutlet var destBox: UITextField!
    @IBOutlet var contentBox: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func sendMessage(_ sender: UIButton) {
        let collection = Firestore.firestore().collection("messages")
        
        guard let message = Message(content: contentBox.text, senderEmail: (Auth.auth().currentUser?.email)!,
                                    timestamp: Date().timeIntervalSince1970) else{
                                        fatalError("Unable to instantiate Message")
        }
        collection.addDocument(data: message.dictionary)
        destBox.text = ""
        contentBox.text = ""

        //segue?
        
        let alertController = UIAlertController(title: "Success", message: "Message sent!", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
