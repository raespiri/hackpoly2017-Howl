//
//  ViewController2.swift
//  Howl
//
//  Created by Jonathon Shen on 2/11/17.
//  Copyright © 2017 jonashen. All rights reserved.
//

import Foundation
import UIKit

class ViewController2: UIViewController {
    
    var parsedString = ""
    @IBOutlet weak var parsedStringDisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parsedStringDisplay.text = parsedString
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
