//
//  informationController.swift
//  Howl
//
//  Created by Toshitaka on 2/11/17.
//  Copyright © 2017 jonashen. All rights reserved.
//

import UIKit

class informationController: UIViewController {

    @IBOutlet weak var descriptionText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionText.isEditable = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismissing(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
