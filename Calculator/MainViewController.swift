//
//  MainViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/13/21.
//

import UIKit

class MainViewController: UIViewController, KeyboardDataProtocol {
    
    @IBOutlet weak var screenResultLabel: UILabel!
    var calculatorBrain = BrainNormalCalculator()
    var operand = "0"
    var enteringNumber = false
    var dotIsSet = false
    var operandValue: Double {
        get {
            return Double(screenResultLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                screenResultLabel.text = "\(valueArray[0])"
            } else {
                screenResultLabel.text = "\(newValue)"
            }
            enteringNumber = true
        }
    }
    
    @IBOutlet weak var keyboardConteinerView: UIView!
    
    lazy var normalViewController: NormalViewController = {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           var viewController = storyboard.instantiateViewController(withIdentifier: "NormalVC") as! NormalViewController
           self.addViewControllerAsChildViewController(chaildViewController: viewController)
           return viewController
       }()
       
       lazy var engineeringViewController: EngineeringViewController = {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           var viewController = storyboard.instantiateViewController(withIdentifier: "EngineeringVC") as! EngineeringViewController
           self.addViewControllerAsChildViewController(chaildViewController: viewController)
           return viewController
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalViewController.view.isHidden = false
    }
    
    private func addViewControllerAsChildViewController(chaildViewController:UIViewController){
        guard  var chaildViewController = chaildViewController as? UIViewController & KeyboardDelegate else {
            return
            }
        chaildViewController.inputDelegate = self
        addChild(chaildViewController)
        keyboardConteinerView.addSubview(chaildViewController.view)
        chaildViewController.view.frame = keyboardConteinerView.bounds
        chaildViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        chaildViewController.didMove(toParent: self)
        }
    
    func errorMessage() {
        screenResultLabel.text = "invalid operation"
    }
    
    func passValue(setOperand:Bool){
        if !calculatorBrain.error {
        if setOperand{
        guard let num = Double(operand) else {return}
        calculatorBrain.setOperand(operand: num)
        }
        operandValue = calculatorBrain.result
        } else {
            errorMessage()
        }
    }
    
    @IBAction func changeVCSegmentControl(_ sender: UISegmentedControl) {
        UIView.transition(from: normalViewController.view, to: engineeringViewController.view, duration: 1, options:[.curveEaseOut, .transitionFlipFromLeft, .showHideTransitionViews])
               normalViewController.view.isHidden = true
               engineeringViewController.view.isHidden = true
               if sender.selectedSegmentIndex == 0 {
                   normalViewController.view.isHidden = false
               } else {
                  engineeringViewController.view.isHidden = false
               }
        }
    
    func enteringNumberTransmission(number: String) {
        if enteringNumber {
                operand = operand + number
            } else {
                operand = number
                enteringNumber = true
            }
        screenResultLabel.text = operand
        passValue(setOperand: true)
        }
    
        func decimalPointTransmission() {
                if enteringNumber && !dotIsSet {
                    operand = operand + "."
                    dotIsSet = true
                } else if !enteringNumber && !dotIsSet {
                    operand = "0."
                    enteringNumber = true
                }
         }

    func operationTransmission(operationType:String) {
        if !calculatorBrain.error {
        calculatorBrain.typeOfOperation(operation:operationType)
        calculatorBrain.setOperand(operand:operandValue )
        operand = "0"
        dotIsSet = false
        enteringNumber = false
        }
        }
    
    func equalTransmission() {
        calculatorBrain.applyEqual()
        passValue(setOperand: false)
        }
    
    func cleanTrasmission() {
        enteringNumber = false
        screenResultLabel.text = "0"
        calculatorBrain.operandArray = [0.0,0.0]
        calculatorBrain.indexOperand = 0
        calculatorBrain.operationType = ""
        calculatorBrain.resultValue = 0
        calculatorBrain.error = false
        dotIsSet = false
    }
   
    func removeTheLastCharesterTransmission() {
        if enteringNumber  {
            if operand.count > 1 {
                operand.remove(at: operand.index(before: operand.endIndex))
            } else {
                operand = "0"
                enteringNumber = false
            }
            passValue(setOperand: true)
        }
    }
    
    func unaryOperationTransmission(operationType:String) {
        calculatorBrain.unaryOperation(operation: operationType)
        passValue(setOperand: false)
        
    }
}

