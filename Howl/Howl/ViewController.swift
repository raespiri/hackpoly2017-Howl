//
//  ViewController.swift
//  Howl
//
//  Created by Jonathon Shen on 2/11/17.
//  Copyright © 2017 jonashen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var border: UIButton!
    @IBOutlet weak var textField: UITextView!
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.image.transform = CGAffineTransform(rotationAngle: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let DestViewController : ViewController2 = (segue.destination as? ViewController2)!
//        DestViewController.parsedString = textField.text
//    }
}

