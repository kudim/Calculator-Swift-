//
//  ViewController.swift
//  Calculator
//
//  Created by Dmitry Anikin on 21/11/2017.
//  Copyright © 2017 KudimovMikhail. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentDigit : String = ""
    var currentSign : String = ""
    var justChangeSign : Bool = false
    @IBOutlet weak var labelAnswer: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
        labelAnswer.text = "0"
        currentSign = ""
        currentDigit = "0"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      /*  let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        labelAnswer.frame.size.height = screenHeight - 5 * (screenWidth / 4)*/
        for button in buttons {            //button.frame.size.width = screenWidth / 4
           // button.frame.size.height = screenWidth / 4
            button.layer.borderWidth = 0.3
        }
}

    @IBAction func clearLabel(_ sender: Any) {
        labelAnswer.text? = "0"
        currentSign = ""
        currentDigit = "0"
        justChangeSign = false
    }
    @IBAction func changeSign(_ sender: Any) {
        if labelAnswer.text != "0" {
            if labelAnswer.text?.characters.first != "-" {
                labelAnswer.text?.insert("-", at: (labelAnswer.text?.startIndex)!)
            }
            else {
                labelAnswer.text?.remove(at: (labelAnswer.text?.startIndex)!)
            }
        }
    }
    
    @IBAction func clickPercent(_ sender: Any) {
        let cost = Double((labelAnswer.text)!)
            let newDigit = cost! / 100
        if newDigit.truncatingRemainder(dividingBy: 1) == 0 {
            labelAnswer.text = String(describing:Int(newDigit))
        }
        else {
            labelAnswer.text = String(newDigit)
        }
    }
    
    @IBAction func clickDot(_ sender: Any) {
        if justChangeSign {
            currentDigit = (labelAnswer.text)!
            justChangeSign = false
            labelAnswer.text? = "0."
        }
        else {
            for ch in (labelAnswer.text?.characters)! {
                if ch == "." {
                    return
                }
            }
            labelAnswer.text?.append(".")
        }
    }
    
    @IBAction func clickDigit(_ sender: Any) {
        let button = sender as! UIButton
        
        if Double((labelAnswer?.text)!) != nil && !justChangeSign
        {
            if labelAnswer.text == "0" {
                labelAnswer.text = (button.titleLabel?.text)!
            }
            else {
                labelAnswer.text?.append((button.titleLabel?.text)!)
            }
        }
        else {
            currentDigit = (labelAnswer.text)!
            justChangeSign = false
            labelAnswer.text = (button.titleLabel?.text)!
        }
    }
    
    
    @IBAction func clickSign(_ sender: Any) {
        let button = sender as! UIButton
        if currentSign == "" {
            currentSign = (button.titleLabel?.text)!
            justChangeSign = true
            return
        }
        else if currentSign == "+" {
                currentDigit = String(Double(currentDigit)! + Double((labelAnswer?.text)!)!)
            }
        else if currentSign == "-" {
            currentDigit = String(Double(currentDigit)! - Double((labelAnswer?.text)!)!)
        }
        else if currentSign == "X" {
            currentDigit = String(Double(currentDigit)! * Double((labelAnswer?.text)!)!)
        }
        else if  currentSign == "/" {
            currentDigit = String(Double(currentDigit)! / Double((labelAnswer?.text)!)!)
        }
        if button.titleLabel?.text == "=" {
            currentSign = ""
        }
        else {
            currentSign = (button.titleLabel?.text)!
        }
        justChangeSign = true
        if Double(currentDigit)?.truncatingRemainder(dividingBy: 1) == 0 {
            labelAnswer.text = String(describing:Int(Double(currentDigit)!))
            }
        else {
            labelAnswer.text = currentDigit
        }
        currentDigit = ""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

