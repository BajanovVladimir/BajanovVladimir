//
//  MainViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/13/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var screenResultLabel: UILabel!
    var calculatorBrain = BrainNormalCalculator()
    var operand = "0"
    var enteringNumber = false
    var dotIsSet = false
    var operandValue: Double {
        get {
            guard  let screenResultString = screenResultLabel.text, let screenResultDouble = Double(screenResultString) else {
                return 0.0
            }
            return screenResultDouble
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
}

extension MainViewController: KeyboardDataProtocol {
   
    func errorMessage() {
        screenResultLabel.text = "invalid operation"
    }
    
    func transferTheOperandToTheBrain () {
        guard let operandDouble = Double(operand) else {
            return
        }
        calculatorBrain.setOperand(operand: operandDouble)
    }
    
    func displayTheBrainResultOnTheScreen() -> Double {
        return calculatorBrain.result
    }
  
    
    func enteringNumberTransmission(number: String) {
        if enteringNumber {
            operand = operand + number
        } else {
            operand = number
            enteringNumber = true
        }
        transferTheOperandToTheBrain()
        operandValue = displayTheBrainResultOnTheScreen()
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
        calculatorBrain.typeOfOperation(operation: operationType)
        dotIsSet = false
        operand = ""
        enteringNumber = false
        operandValue = displayTheBrainResultOnTheScreen()
        }
    
    func cleanTrasmission() {
        enteringNumber = false
        screenResultLabel.text = "0"
        calculatorBrain.operandArray = []
        calculatorBrain.operationType = []
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
            transferTheOperandToTheBrain()
            operandValue = displayTheBrainResultOnTheScreen()
        }
    }
    
    func unaryOperationTransmission(operationType:String) {
        calculatorBrain.unaryOperation(operation: operationType)
        operandValue = displayTheBrainResultOnTheScreen()
    }
}

