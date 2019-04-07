//
//  ChannelsViewController.swift
//  ZwaxMessenger
//
//  Created by Ryden Neal on 3/14/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ChannelsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    private var channels = [Channel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        loadChannels()
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
    @IBAction func logOut(_ sender: UIButton) {
        userLogOut()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "ChannelTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChannelTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let channel = channels[indexPath.row]
        
        cell.channelName.text = channel.channelName
        cell.channelDescription.text = channel.channelDescription
        
        return cell
    }
    
    private func loadChannels(){ // grab data from firebase
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
        let msgRef = db.collection("channels").addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            for document in snapshot.documents{ // iterates through each message
                let channelName : String = document.data()["channelName"] as! String
                guard let newChannel =
                    Channel(
                        channelName:document.data() ["channelName"] as! String,
                        channelDescription:document.data() ["channelDescription"] as! String,
                        users:document.data() ["users"] as! [String]
                    )
                    else{
                        fatalError("Unable to instantiate Channel")
                    }
                self.channels.append(newChannel)
            }
            self.tableView.reloadData()
        }
    }
}
