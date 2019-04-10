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

class ChatsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var channelNameLabel: UILabel!
    @IBOutlet var messageBox: UITextField!
    @IBOutlet var tableView: UITableView!
    
    var messages = [Message]()
    
    var channelID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        loadMessages()
        channelNameLabel.text = ChannelsViewController.currentChannelName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MessageTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell")
        }
        
        let message = messages[indexPath.row]
        
        cell.senderEmailLabel.text = message.senderEmail
        cell.messageLabel.text = message.content
        
        return cell
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let db = Firestore.firestore()
        let channels = db.collection("channels")
        
        let chRef = channels.addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            for document in snapshot.documents{
                if(document.data()["channelName"] as! String == ChannelsViewController.currentChannelName){ // finding the channel id
                    self.channelID = document.documentID
                }
            }
        }
        let messages = channels.document(channelID).collection("messages")
           guard let message = Message(content: messageBox.text!, senderEmail: (Auth.auth().currentUser?.email)!,
                                        timestamp: Date().timeIntervalSince1970) else{
                                            fatalError("Unable to instantiate Message")
            }
            messages.addDocument(data: message.dictionary)
        
        messageBox.text = ""
    }
    
    private func loadMessages(){ // grab data from firebase
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let channels = db.collection("channels")
        let msgRef = channels.document(self.channelID).collection("messages").addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            for document in snapshot.documents{ // iterates through each message
                    guard let newmessage =
                        Message(
                            content:document.data()["content"] as! String,
                            senderEmail:document.data()["sender"] as! String,
                            timestamp:document.data()["timestamp"] as! Double)
                        else{
                            fatalError("Unable to instantiate Message")
                    }
                    print(newmessage)
                    self.messages.append(newmessage)
            }
            self.tableView.reloadData()
        }
    }
}
