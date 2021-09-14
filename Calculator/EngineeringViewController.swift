//
//  EngineeringViewController.swift
//  Calculator
//
//  Created by Владимир Бажанов on 08.09.2021.
//

import UIKit

class EngineeringViewController: UIViewController {

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
    
    @IBAction func equalButtonPress(_ sender: UIButton) { if !errorOccurrence {
        if enteringNumber {
        secondOperand = operandValue
        switch operation {
        case "xⁿ":
            var degree = Int(operandValue)
            operandValue = 1.0
            if degree == 0{
                operandValue = 1
            } else {
            if degree < 0  {
                degree = -degree
                firstOperand = 1/firstOperand
            }
                for _ in 1...degree {
              operandValue = operandValue * firstOperand
            }
        }
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
    
    @IBAction func remaveTheLastCharesterButtonPress(_ sender: UIButton) {
        if enteringNumber && !errorOccurrence {
        if resultOutputLabel.text!.count > 1 {
        resultOutputLabel.text!.remove(at: resultOutputLabel.text!.index(before: resultOutputLabel.text!.endIndex))
    } else {
            resultOutputLabel.text = "0"
            enteringNumber = false
      }
    }
 }
    
    @IBAction func signChangeButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        operandValue = -operandValue
        }
    }
    
    @IBAction func squareRootButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        if operandValue >= 0 {
        enteringNumber = false
        operandValue = sqrt(operandValue)
        } else {
            resultOutputLabel.adjustsFontSizeToFitWidth = true
            resultOutputLabel.minimumScaleFactor = 0.2
          resultOutputLabel.text = "Недопустимая операция"
            errorOccurrence = true
        }
     }
   }
    
    @IBAction func decimalPointSettingButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        if enteringNumber && !dotIsSet {
            resultOutputLabel.text = resultOutputLabel.text! + "."
              dotIsSet = true
        } else  if !enteringNumber && !dotIsSet {
            resultOutputLabel.text = "0."
          }
        }
    }
    
    @IBAction func percentButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        enteringNumber = false
        operandValue = firstOperand - firstOperand * operandValue / 100
        }
    }
    
    @IBAction func unitDividedByNumberButtonPress(_ sender: UIButton) {       
        if !errorOccurrence{
        if operandValue != 0{
        operandValue = 1/operandValue
        } else {
            resultOutputLabel.adjustsFontSizeToFitWidth = true
            resultOutputLabel.minimumScaleFactor = 0.2
          resultOutputLabel.text = "Недопустимая операция"
            errorOccurrence = true
        }
       }
    enteringNumber = false
    }
    
    @IBAction func degreeNumberButtonPress(_ sender: UIButton) {
        if !errorOccurrence{
        firstOperand = operandValue
        enteringNumber = false
        }
    }
    
    @IBAction func tenToThePowerNumberButtonPress(_ sender: UIButton) {
        if !errorOccurrence {
        let degree = Int(operandValue)
        if degree < 11{
        operandValue = 1
        for _ in 0..<degree {
         operandValue = 10 * operandValue
        }
      }
     }
        enteringNumber = false
    }
    
    @IBAction func factorialNumberButtenPress(_ sender: UIButton) {
        enteringNumber = false
        
        
        if !errorOccurrence {
        let number = Int(operandValue)
        if number<0 { resultOutputLabel.adjustsFontSizeToFitWidth = true
            resultOutputLabel.minimumScaleFactor = 0.2
          resultOutputLabel.text = "Недопустимая операция"
            errorOccurrence = true
        } else {
        if operandValue == 0{
        operandValue=1
        } else {
        operandValue=1
        for col in 1...number {
            operandValue = operandValue * Double(col)
        }
      }
    }
   }
  }
    
}

