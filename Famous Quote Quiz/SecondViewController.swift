//
//  SecondViewController.swift
//  Famous Quote Quiz
//
//  Created by Ivaylo Todorov on 26.02.16 г..
//  Copyright © 2016 г. Ivaylo Todorov. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var multipleSwitch: UISwitch!
    @IBAction func switchTapped(let sender: AnyObject) {

        if multipleSwitch.on {
            
            NSNotificationCenter.defaultCenter().postNotificationName("SwitchTapON", object: sender)
            
        } else {
            
            NSNotificationCenter.defaultCenter().postNotificationName("SwitchTapOFF", object: sender)
        }
 
    }

// func to return the switch value of OFF / false whem the new game start
    func switchResetFunc(notification: NSNotification) {
       
     multipleSwitch.setOn(false, animated: true)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switchResetFunc:", name:"switchReset", object: nil)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()     
       
    }

}