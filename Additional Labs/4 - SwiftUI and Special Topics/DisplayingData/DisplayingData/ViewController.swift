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
    @IBOutlet var randomColorButton: UIButton!
    @IBOutlet var tealColorButton: UIButton!
    @IBOutlet var redColorButton: UIButton!
    let mainLabelText1 = "Many Fancy Sunset Photos"
    let mainLabelText2 = "Some Kinda Fancy Photos"
    let mainLabelText3 = "Are these even photos?"
    private var textValue = 1
    
    
    @IBAction func changeBackgroundToRed(_ sender: Any) {
        view.backgroundColor = .systemRed
    }
    @IBAction func changeBackgroundToRandom(_ sender: Any) {
        let randomColor = UIColor(
            red: CGFloat.random(in: 0...1),
            green: CGFloat.random(in: 0...1),
            blue: CGFloat.random(in: 0...1),
            alpha: 1.0
        )
        view.backgroundColor = randomColor
    }
    @IBAction func changeBackgroundToTeal(_ sender: Any) {
        view.backgroundColor = .systemTeal
    }
    @IBAction func cycleText(_ sender: Any) {
        if textValue >= 3 {
            textValue = 1
        }
        switch textValue {
        case 1:
            mainLabel.text = mainLabelText1
        case 2:
            mainLabel.text = mainLabelText2
        case 3:
            mainLabel.text = mainLabelText3
        default:
            mainLabel.text = mainLabelText1
        }
        textValue += 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

