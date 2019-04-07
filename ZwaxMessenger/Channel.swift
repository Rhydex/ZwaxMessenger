//
//  Channel.swift
//  ZwaxMessenger
//
//  Created by Ryden Neal on 3/28/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import Foundation
import Firebase

struct Channel {
    
    var channelName : String
    var channelDescription: String
    var users: [String]
    
    init?(channelName: String, channelDescription: String, users: [String]) {
        self.channelName = channelName
        self.channelDescription = channelDescription
        self.users = users
    }
    
    var dictionary: [String: Any] {
        return [
            "channelName": channelName,
            "channelDescription": channelDescription,
            "users": users,
        ]
    }
}

extension Channel : DocumentSerializable{
    init?(dictionary: [String : Any]) {
        guard let channelName = dictionary["channelName"] as? String,
            let channelDescription = dictionary["channelDescription"] as? String,
            let users = dictionary["users"] as? [String]
            else { return nil }
        
        self.init(channelName: channelName,
                  channelDescription: channelDescription,
                  users: users)
    }
}
