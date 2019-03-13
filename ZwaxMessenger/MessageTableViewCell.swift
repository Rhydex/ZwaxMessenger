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

    @IBOutlet var destName: UILabel!
    @IBOutlet var lastMessage: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // segue to chat screen with the other person and populate time ordered messages
    }
    
}
