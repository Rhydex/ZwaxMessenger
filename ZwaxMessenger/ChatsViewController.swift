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
        //loadSampleMessages()
        loadReceivedMessages()
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
    
    private func loadSentMessages(){ // grab data from firebase
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let msgRef = db.collection("messages").addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            for document in snapshot.documents{ // iterates through each message
                let senderEmail : String = document.data()["senderEmail"] as! String
                if(senderEmail == currentUser?.email){
                    guard let newmessage =
                        Message(
                            content:document.data()["content"] as! String,
                            senderEmail:document.data()["senderEmail"] as! String,
                            destinationEmail:document.data()["destinationEmail"] as! String,
                            timestamp:document.data()["timestamp"] as! Double)
                        else{
                            fatalError("Unable to instantiate Message")
                    }
                    print(newmessage)
                    self.messages.append(newmessage)
                }
                else{
                    //print("not your message!")
                }
            }
            self.tableView.reloadData()
        }
        // sent messages
        
        
    }
    private func loadReceivedMessages(){ // grab data from firebase
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let msgRef = db.collection("messages").addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            for document in snapshot.documents{ // iterates through each message
                let destinationEmail : String = document.data()["destinationEmail"] as! String
                if(destinationEmail == currentUser?.email){
                    guard let newmessage =
                        Message(
                            content:document.data()["content"] as! String,
                            senderEmail:document.data()["senderEmail"] as! String,
                            destinationEmail:document.data()["destinationEmail"] as! String,
                            timestamp:document.data()["timestamp"] as! Double)
                        else{
                            fatalError("Unable to instantiate Message")
                    }
                    print(newmessage)
                    self.messages.append(newmessage)
                }
                else{
                    //print("not your message!")
                }
            }
            self.tableView.reloadData()
        }
    }
}
