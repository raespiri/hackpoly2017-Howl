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
        let pod_parser = podParser(input: parsedString)
        pod_parser.startParse()
        for pod in pod_parser.returnPods() {
            if pod.title == "Derivative" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
            else if pod.title == "Indefinite integral" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
            else if pod.title == "Definite integral" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
            else if pod.title == "Exact result" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
            else if pod.title == "Mixed fraction" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
            else if pod.title == "Result" {
                parsedStringDisplay.text = pod.plaintext
                break
            }
        }
    }
    
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
