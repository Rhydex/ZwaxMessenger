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
    weak var delegate: MessageTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func viewButtonTapped(_ sender: UIButton) {
        delegate?.MessageTableViewCellTappedView(self)
    }
    
}
protocol MessageTableViewCellDelegate : class{
    func MessageTableViewCellTappedView(_ sender: MessageTableViewCell)
}
