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
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.global(qos: .background).async {
//            while (true) {
//                print(self.flag) //
////                if self.flag {
//                    self.border.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
//                    self.image.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
////                }
////                else { print("stopped") }//
//            }
        while true {
        UIView.animate(withDuration: 1.0, animations: ({
            self.image.transform = CGAffineTransform(rotationAngle: 1) }))
            print("hi")
        }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rotate360(_ sender: Any) {
        if flag {
            flag = false
        }
        else {
            flag = true
        }
        border.isEnabled = true
        
//        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { () -> Void in
//            
//            self.image.transform = self.image.transform.rotated(by: CGFloat(M_PI))
//            self.border.transform = self.border.transform.rotated(by: CGFloat(M_PI))
//        }) { (finished) -> Void in
//            self.rotate360(sender)
//        }
    }
    
//    func rotation() {
//        UIView.animate(withDuration: 0.5, delay: 0.45, options: UIViewAnimationOptions.curveEaseIn
//            , animations: { () -> Void in
//            
//            self.border.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
//            self.image.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI))
//        }, completion: nil)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let DestViewController : ViewController2 = (segue.destination as? ViewController2)!
        DestViewController.parsedString = textField.text
    }
}

