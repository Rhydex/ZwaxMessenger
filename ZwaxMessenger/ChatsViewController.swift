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
import MobileCoreServices

class ChatsViewController: UIViewController, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var channelNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!

    @IBOutlet var messageBox: UITextView!
    
    var timer : Timer!
    
    var messages = [Message]()
    var picArray = [UIImage]()
    var order = [Int]()
    var database: Database!
    var storage: Storage!
    var counter = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        messageBox!.layer.borderWidth = 1 // adds a border
        channelNameLabel.text = ChannelsViewController.currentChannelName
        tableView.dataSource = self
        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(refreshTable), userInfo: nil, repeats: true)
        loadMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate() // stops timer
    }
    
    @objc func refreshTable(){
        loadMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count + picArray.count
    }
    
    @IBAction func sendPhoto(_ sender: Any) {
        let profileImagePicker = UIImagePickerController()
        profileImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        profileImagePicker.mediaTypes = [kUTTypeImage as String]
        profileImagePicker.delegate = self
        present(profileImagePicker, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MessageTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MessageTableViewCell")
        }
        if(order[indexPath.row] == 1)
        {
        let message = messages[indexPath.row]
        
        cell.senderEmailLabel.text = message.senderEmail
        cell.messageLabel.text = message.content
        }
        else{
            cell.imageView?.image = picArray[indexPath.row]
        }
        return cell
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let db = Firestore.firestore()
        let channels = db.collection("channels")
        let messages = channels.document(ChannelsViewController.currentChannelID).collection("messages")
           guard let message = Message(content: messageBox.text!, senderEmail: (Auth.auth().currentUser?.email)!,
                                        timestamp: Date().timeIntervalSince1970) else{
                                            fatalError("Unable to instantiate Message")
            }
            messages.addDocument(data: message.dictionary)
        
        messageBox.text = ""
        loadMessages()
    }
    
    
    
    private func sortMessages(){
        messages.sort(by: { $0.timestamp > $1.timestamp })
    }
    
    private func loadMessages(){ // grab data from firebase
        print("loading messages from", ChannelsViewController.currentChannelName)
        let currentUser = Auth.auth().currentUser
        let db = Firestore.firestore()
    db.collection("channels").document(ChannelsViewController.currentChannelID).collection("messages").addSnapshotListener{
            querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error retreiving snapshots \(error!)")
                return
            }
            self.messages.removeAll()
            for document in snapshot.documents{ // iterates through each message
                    guard let newmessage =
                        Message(
                            content:document.data()["content"] as! String,
                            senderEmail:document.data()["senderEmail"] as! String,
                            timestamp:document.data()["timestamp"] as! Double)
                        else{
                            fatalError("Unable to instantiate Message")
                    }
                    self.messages.append(newmessage)
                    self.order.append(1)
            }
        self.sortMessages()
        self.tableView.reloadData()
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let profileImage = info[.originalImage] as? UIImage, let optimizedImageData =  profileImage.jpegData(compressionQuality: 0.6)
        {
            // upload image from here
            uploadProfileImage(imageData: optimizedImageData)
        }
        picker.dismiss(animated: true, completion:nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion:nil)
    }
    
    func uploadProfileImage(imageData: Data)
    {
        let activityIndicator = UIActivityIndicatorView.init(style: .gray)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
        
        
        let storageReference = Storage.storage().reference()
        let currentUser = Auth.auth().currentUser
        let profileImageRef = storageReference.child("users").child(currentUser!.uid).child("\(currentUser!.uid)-profileImage.jpg")

            // Write the download URL to the Realtime Database
        let uploadMetaData = StorageMetadata()
        uploadMetaData.contentType = "image/jpeg"
        
        profileImageRef.putData(imageData, metadata: uploadMetaData) { (uploadedImageMeta, error) in
            
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            if error != nil
            {
                print("Error took place \(String(describing: error?.localizedDescription))")
                return
            } else {
                
                //self.userProfileImageView.image = UIImage(data: imageData)
                
                print("Meta data of uploaded image \(String(describing: uploadedImageMeta))")
            }
        }
    }
}
