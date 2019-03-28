//
//  ChannelsViewController.swift
//  ZwaxMessenger
//
//  Created by Ryden Neal on 3/14/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Firebase

class ChannelsViewController: UIViewController, UITableViewDataSource {
  
    
    @IBOutlet var channelTable: UITableView!
    @IBOutlet var userEmail: UILabel!
    
    private var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        channelTable.register(MessageTableViewCell.self, forCellReuseIdentifier: "MessageTableViewCell")
        channelTable.dataSource = self
        userEmail.text = Auth.auth().currentUser?.email
        loadSampleMessages()
    }
    
    func userLogOut(){ // returns to login view and displays popup
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
    func loadMessages(){ // loads the most recent message from the database as a table view cell
        //use firebase to get the most recent message from each other user/channel
    }
    @IBAction func logOut(_ sender: UIButton) {
        userLogOut()
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell") as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell.")
        }
        
        let msg = messages[indexPath.row]
        
        cell.destName?.text = msg.destinationEmail
        cell.lastMessage?.text = msg.content
        
        return cell
    }

}
