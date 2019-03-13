//
//  ChatsViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 3/11/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ChatsViewController: UITableViewController {
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MessageTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let message = messages[indexPath.row]
        
        cell.destName.text = message.senderEmail
        cell.lastMessage.text = message.content
        
        return cell
    }
    
    private func loadUserMessages(){ // grab data from firebase
        //let currentUser = Auth.auth().currentUser
        //let collection = Firestore.firestore().collection("messages")
    }
    
    private func loadSampleMessages(){
        guard let testMessage0 =
            Message(content:"test",senderEmail:"test0@test.com",destinationEmail:"test2@test2.com", timestamp:Date().timeIntervalSince1970) else{
                fatalError("Unable to instantiate Message")
        }
        guard let testMessage1 =
            Message(content:"test1",senderEmail:"test1@test.com",destinationEmail:"test2@test2.com", timestamp:Date().timeIntervalSince1970) else{
                fatalError("Unable to instantiate Message")
        }
        guard let testMessage2 =
            Message(content:"test2",senderEmail:"test2@test.com",destinationEmail:"test2@test2.com", timestamp:Date().timeIntervalSince1970) else{
                fatalError("Unable to instantiate Message")
        }
        guard let testMessage3 =
            Message(content:"test3",senderEmail:"test3@test.com",destinationEmail:"test2@test2.com", timestamp:Date().timeIntervalSince1970) else{
                fatalError("Unable to instantiate Message")
        }
        guard let testMessage4 =
            Message(content:"test4",senderEmail:"test4@test.com",destinationEmail:"test2@test2.com", timestamp:Date().timeIntervalSince1970) else{
                fatalError("Unable to instantiate Message")
        }
        messages.append(testMessage0)
        messages.append(testMessage1)
        messages.append(testMessage2)
        messages.append(testMessage3)
        messages.append(testMessage4)
    }
}
