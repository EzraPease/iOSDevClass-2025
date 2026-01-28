//
//  ViewController.swift
//  DisplayingData
//
//  Created by Ezra Pease on 1/28/26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var cycleTextButton: UIButton!
    @IBOutlet var mainLabel: UILabel!
    
    @IBAction func cycleText(_ sender: Any) {
        mainLabel.text = "Some Kinda Fancy Photos"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

