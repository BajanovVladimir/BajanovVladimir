//
//  EngineeringViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 08.09.2021.
//

import UIKit

class EngineeringViewController: UIViewController, KeyboardDelegate {

    var inputDelegate: KeyboardDataProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func numberPressed(_ sender: UIButton) {
        inputDelegate?.enteringNumberTransmission(number: sender.currentTitle!)
    }
    

}
