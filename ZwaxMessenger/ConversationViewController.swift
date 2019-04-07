//
//  ConversationViewController.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 4/6/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit
import Photos
import Firebase
import MessageKit
import FirebaseFirestore

class ConversationViewController: MessagesViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ConversationViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return (message.sender.displayName == Auth.auth().currentUser?.email) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = (message.sender.displayName == Auth.auth().currentUser?.email) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}
extension ConversationViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: Message, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: Message, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: Message, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
}
