//
//  ConversationViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 4/6/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Photos
import Firebase
import MessageKit
import FirebaseFirestore

class ConversationViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var channelLabel: UILabel!
    @IBOutlet var messageText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func sendMessage(_ sender: Any) {
        
    }
}
