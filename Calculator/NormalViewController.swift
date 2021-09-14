//
//  NormalViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 31.08.2021.
//

import UIKit

class NormalViewController: UIViewController {

    @IBOutlet weak var resultOutputLabel: UILabel!
    var errorOccurrence = false
    var enteringNumber = false
    var firstOperand = 0.0
    var secondOperand = 0.0
    var dotIsSet = false
    var operation = ""
    var operandValue: Double {
        get {
            return Double(resultOutputLabel.text!)!
        }
        set {
            let value = "\(newValue)"
            let valueArray = value.components(separatedBy: ".")
            if valueArray[1] == "0" {
                resultOutputLabel.text = "\(valueArray[0])"
            } else {
              resultOutputLabel.text = "\(newValue)"
              }
             enteringNumber = true
        }
    }
    
    func operateWithTwoOperand(operationTwo:(Double,Double) -> Double) {
        operandValue = operationTwo(firstOperand,secondOperand)
        enteringNumber = false
    }
    
    @IBAction func numberButtonPress(_ sender: UIButton) {
        if !errorOccurrence{
        let number = sender.currentTitle!
        if enteringNumber {
         if resultOutputLabel.text!.count < 15 {
         resultOutputLabel.text = resultOutputLabel.text! + number
         }
        } else {
           resultOutputLabel.text  = number
            enteringNumber = true
        }
        }
  }
    
    @IBAction func operationEntryButtonPress(_ sender: UIButton) {
        if !errorOccurrence{
        operation = sender.currentTitle!
        firstOperand = operandValue
        enteringNumber = false
        }
    }
   
    @IBAction func equalButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        if enteringNumber {
        secondOperand = operandValue
        switch operation {
        case "+": operateWithTwoOperand{$0 + $1}
        case "-": operateWithTwoOperand{$0 - $1}
        case "×": operateWithTwoOperand{$0 * $1}
        case "÷":
            if secondOperand != 0{
            operateWithTwoOperand{$0 / $1}
            } else {
                resultOutputLabel.adjustsFontSizeToFitWidth = true
                resultOutputLabel.minimumScaleFactor = 0.2
              resultOutputLabel.text = "Деление на ноль"
                errorOccurrence = true
              }
        default: break
        }
      }
     }
        enteringNumber = false
        operation = ""
        dotIsSet = false
    }
    
    @IBAction func cleanButtonPress(_ sender: UIButton) {
        firstOperand = 0
        secondOperand = 0
        enteringNumber = false
        resultOutputLabel.text = "0"
        operation = ""
        errorOccurrence = false
        dotIsSet = false
    }
    
    @IBAction func signChangeButtonPress(_ sender: Any) {
        if !errorOccurrence {
        operandValue = -operandValue
        }
    }
    
    @IBAction func decimalPointSetttingButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        if enteringNumber && !dotIsSet {
            resultOutputLabel.text = resultOutputLabel.text! + "."
              dotIsSet = true
        } else  if !enteringNumber && !dotIsSet {
            resultOutputLabel.text = "0."
          }
        }
    }
    
    @IBAction func removeTheLastCharasterButtonPress(_ sender: UIButton) {
        if enteringNumber && !errorOccurrence {
        if resultOutputLabel.text!.count > 1 {
        resultOutputLabel.text!.remove(at: resultOutputLabel.text!.index(before: resultOutputLabel.text!.endIndex))
    } else {
            resultOutputLabel.text = "0"
            enteringNumber = false
      }
    }
  }
    
    @IBAction func squareRootButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        if operandValue >= 0 {
        operandValue = sqrt(operandValue)
           enteringNumber = false
        } else {
            resultOutputLabel.adjustsFontSizeToFitWidth = true
            resultOutputLabel.minimumScaleFactor = 0.2
          resultOutputLabel.text = "Недопустимая операция"
            errorOccurrence = true
        }
     }
    }
}

