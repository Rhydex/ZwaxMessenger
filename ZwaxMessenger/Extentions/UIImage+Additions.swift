//
//  UIImage+Additions.swift
//  ZwaxMessenger
//
//  Created by Kevin Hoffmeister on 4/7/19.
//  Copyright © 2019 Ryden Neal. All rights reserved.
//

import UIKit

extension UIView {
    
    func smoothRoundCorners(to radius: CGFloat) {
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: radius
            ).cgPath
        
        layer.mask = maskLayer
    }
    
}
