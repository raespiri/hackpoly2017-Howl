//
//  CircleButton.swift
//  Howl
//
//  Created by Jonathon Shen on 2/11/17.
//  Copyright © 2017 jonashen. All rights reserved.
//

import UIKit

// Auto updates the button to be round
@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 125.0 {
        // Edit corner of button
        didSet {
            setupView()
        }
    }
    
    // Will build
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    // Don't repeat code
    func setupView() {
        layer.cornerRadius = cornerRadius
    }
}
