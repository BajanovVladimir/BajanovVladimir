//
//  NormalViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 31.08.2021.
//

import UIKit

class NormalViewController: UIViewController {

    var inputDelegate: KeyboardDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        inputDelegate?.enteringNumberTransmission(number: sender.currentTitle!)
    }
    
   
    @IBAction func decimalPointPressed(_ sender: UIButton) {
        inputDelegate?.decimalPointTransmission()
    }
    
    @IBAction func operationButtonPressed(_ sender: UIButton) {
        inputDelegate?.operationTransmission(operationType: sender.currentTitle!)
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        inputDelegate?.equalTransmission()
    }
    
    @IBAction func cleanPressed(_ sender: UIButton) {
        inputDelegate?.cleanTrasmission()
    }
    
    @IBAction func removeTheLastCharesterPressed(_ sender: UIButton) {
        inputDelegate?.removeTheLastCharesterTransmission()
    }
    
    @IBAction func signChangePressed(_ sender: UIButton) {
        inputDelegate?.signChangeTransmission()
    }
    
    @IBAction func squareRootPressed(_ sender: UIButton) {
        inputDelegate?.squareRootTransmission()
    }
    
    
    
}


