//
//  ChannelTableViewCell.swift
//  ZwaxMessenger
//
//  Created by Ryden Neal on 3/28/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase

class ChannelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var channelDescription: UILabel!
    @IBOutlet weak var channelName: UILabel!
    
    weak var delegate: ChannelTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // segue to chat screen with the other person and populate time ordered messages
    }
    
    @IBAction func viewButtonClicked(_ sender: Any) {
        delegate?.channelTableViewCellDidTapView(self)
    }
}

protocol ChannelTableViewCellDelegate : class {
    func channelTableViewCellDidTapView(_ sender: ChannelTableViewCell)
}
