//
//  MainViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/13/21.
//

import UIKit

class MainViewController: UIViewController, KeyboardDataProtocol {
   
    @IBOutlet weak var screenResultLabel: UILabel!
   
    @IBOutlet weak var changeViewsSegmentControl: UISegmentedControl!
    
    var errorOccurrence = false
    var enteringNumber = false
    var dotIsSet = false
    var operation = ""
    var firstOperand = 0.0
    var secondOperand = 0.0
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
           self.addViewControllerAsChildViewController(childViewController: viewController)
           return viewController
       }()
       
       lazy var engineeringViewController: EngineeringViewController = {
           let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
           var viewController = storyboard.instantiateViewController(withIdentifier: "EngineeringVC") as! EngineeringViewController
           self.addViewControllerAsChildViewController(childViewController: viewController)
           return viewController
       }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalViewController.view.isHidden = false
    }
    
    
     func addViewControllerAsChildViewController(childViewController:UIViewController){
        guard var childViewController = childViewController as? UIViewController & KeyboardDelegate else {return}
        childViewController.inputDelegate = self
        addChild(childViewController)
        keyboardConteinerView.addSubview(childViewController.view)
        childViewController.view.frame = keyboardConteinerView.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
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
    
    
    func operateWithTwoOperand(operationTwo:(Double, Double) -> Double) {
        operandValue = operationTwo(firstOperand, secondOperand)
        enteringNumber = false
    }
    
    func errorMessage(label:UILabel,message:String){
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.2
        label.text = message
        errorOccurrence = true
    }
    
    func enteringNumberTransmission(number: String) {
        if !errorOccurrence {
           
            if enteringNumber {
                screenResultLabel.text = screenResultLabel.text! + number
            } else {
                screenResultLabel.text = number
                enteringNumber = true
            }
        }
    }
    
        func decimalPointTransmission() {
            if !errorOccurrence {
                if enteringNumber && !dotIsSet {
                    screenResultLabel.text = screenResultLabel.text! + "."
                    dotIsSet = true
                } else if !enteringNumber && !dotIsSet {
                    screenResultLabel.text = "0."
                    enteringNumber = true
                }
            }
        }
    
    func operationTransmission(operationType:String) {
        if !errorOccurrence {
            operation = operationType
            firstOperand = operandValue
            enteringNumber = false
        }
    }
    
    func equalTransmission() {
        print(operation)
        if !errorOccurrence {
            if enteringNumber{
                secondOperand = operandValue
                switch operation {
                case "+": operateWithTwoOperand {$0+$1}
                case "-": operateWithTwoOperand {$0-$1}
                case "×": operateWithTwoOperand {$0*$1}
                case "/":  if secondOperand != 0 {
                 operateWithTwoOperand {$0/$1}
                } else {
                    errorMessage(label: screenResultLabel, message: "Деление на ноль")
                }
               
                default: break
                }
            }
        }
        enteringNumber = false
        operation = ""
        dotIsSet = false
    }
    
    func cleanTrasmission() {
        firstOperand = 0
        secondOperand = 0
        enteringNumber = false
        screenResultLabel.text = "0"
        operation = ""
        errorOccurrence = false
        dotIsSet = false
    }
   
    func removeTheLastCharesterTransmission() {
        if enteringNumber && !errorOccurrence {
            if screenResultLabel.text!.count > 1 {
                screenResultLabel.text!.remove(at: screenResultLabel.text!.index(before: screenResultLabel.text!.endIndex))
            } else {
                screenResultLabel.text = "0"
                enteringNumber = false
            }
            
        }
    }
    
    func signChangeTransmission() {
        if !errorOccurrence {
            operandValue = -operandValue
        }
    }
    
    func squareRootTransmission() {
        if !errorOccurrence {
            if operandValue >= 0 {
                enteringNumber = false
                operandValue = sqrt(operandValue)
            } else{
                errorMessage(label: screenResultLabel, message: "Недопустимая ситуация")
            }
        }
    }
}
