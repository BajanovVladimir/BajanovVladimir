//
//  BrainNarmalCalculator.swift
//  Calculator
//
//  Created by Владимир Бажанов on 10/5/21.
//

import Foundation
class BrainNormalCalculator {
    
    var error = false
    var resultValue = 0.0
    var operandArray = [0.0, 0.0]
    var indexOperand = 0
    var operationType = ""
    var result:Double {
        get {
            return resultValue
        }
    }

    func setOperand(operand:Double){
        operandArray[indexOperand] = operand
        resultValue = operandArray[indexOperand]
        }
    
    
    func typeOfOperation(operation:String){
        if !error  {
        operationType = operation
        indexOperand = 1
        }
    }
    
    func binaryOperation (operationTwo:(Double, Double) -> Double) {
        operandArray[0] = operationTwo(operandArray[0], operandArray[1])
        resultValue = operandArray[0]
        operandArray[1] = 0
        indexOperand = 0
        operationType = ""
        }
    
    func unaryOperation (operation: String){
        switch operation {
        case "√" :
            if operandArray[indexOperand] >= 0 {
            operandArray[indexOperand] = sqrt(operandArray[indexOperand])
            } else {
                error = true
            }
        case "+/-": operandArray[indexOperand] = -operandArray[indexOperand]
        default: break
        }
        resultValue = operandArray[indexOperand]
        }
    
        func applyEqual(){
            if !error {
            switch operationType {
            case "+": binaryOperation {$0 + $1}
            case "-": binaryOperation {$0 - $1}
            case "×": binaryOperation {$0 * $1}
            case "÷":
                if operandArray[1] != 0 {
                binaryOperation {$0 / $1}
                } else {
                    error = true
                }
            default: break
            }
            }
           }
        
}
