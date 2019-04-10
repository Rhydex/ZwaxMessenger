//
//  MessageTableViewCell.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 3/11/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet var senderEmailLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
