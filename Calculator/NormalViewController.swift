//
//  NormalViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 31.08.2021.
//

import UIKit

class NormalViewController: UIViewController {
    
    var inputDelegate:KeyboardDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        inputDelegate?.numberButtonPress(data: sender.currentTitle!)
    }
    
  
}

