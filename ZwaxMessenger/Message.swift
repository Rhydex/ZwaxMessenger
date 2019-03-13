//
//  Message.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 3/11/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import Foundation
import Firebase

struct Message {
    
    var content : String
    var senderEmail: String
    var destinationEmail: String
    var timestamp : TimeInterval
    
    init?(content: String, senderEmail: String, destinationEmail: String, timestamp: TimeInterval ) {
        self.content = content
        self.senderEmail = senderEmail
        self.destinationEmail = destinationEmail
        self.timestamp = timestamp
    }
    
    var dictionary: [String: Any] {
        return [
            "content": content,
            "senderEmail": senderEmail,
            "destinationEmail": destinationEmail,
            "timestamp": timestamp,
        ]
    }
}

extension Message : DocumentSerializable{
    init?(dictionary: [String : Any]) {
        guard let content = dictionary["content"] as? String,
            let senderEmail = dictionary["senderEmail"] as? String,
            let destinationEmail = dictionary["destinationEmail"] as? String,
            let timestamp = dictionary["timestamp"] as? TimeInterval
            else { return nil }
        
        self.init(content: content,
                  senderEmail: senderEmail,
                  destinationEmail: destinationEmail,
                  timestamp: timestamp)
    }
}
