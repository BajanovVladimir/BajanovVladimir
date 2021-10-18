//
//  BrainNarmalCalculator.swift
//  Calculator
//
//  Created by Владимир Бажанов on 10/5/21.
//

import Foundation
class BrainNormalCalculator {
    
    var error = false
    var rememberTheOperand = false
    var resultValue = 0.0
    var operandArray = [Double]()
    var operationType = [String]()
    var firstOperand = 0.0
    var secondOperand = 0.0
    var operationPrioritet = ""
    var typeOfOperation = ""
    var result:Double {
        get {
            return resultValue
        }
    }
    var prioritetOperation :Int {
        switch operationPrioritet {
        case "+":
            return 3
        case "-":
            return 3
        case "=":
            return 3
        case "×":
            return 2
        case "÷":
            return 2
        default:
            return 1
        }
    }
    
    enum operationTypeEnum {
        case UnaryOperation ((Double) -> Double)
        case BinaryOperation ((Double,Double) -> Double)
        case Equals
        
    }
    
    var OperationDictionary: Dictionary <String, operationTypeEnum> = [
        "√": operationTypeEnum.UnaryOperation(sqrt),
        "+/-": operationTypeEnum.UnaryOperation(-),
        "+": operationTypeEnum.BinaryOperation({$0+$1}),
        "-": operationTypeEnum.BinaryOperation({$0-$1}),
        "×": operationTypeEnum.BinaryOperation({$0*$1}),
        "÷": operationTypeEnum.BinaryOperation({$0/$1}),
    ]

    func setOperand(operand:Double){
        rememberTheOperand = true
        resultValue = operand
    }
    func performTheOperation () {
        typeOfOperation = operationType.removeLast()
        secondOperand = operandArray.removeLast()
        firstOperand = operandArray.removeLast()
        applyOperation(operationSymbol: typeOfOperation)
        operandArray.append(result)
    }
    
    func typeOfOperation(operation:String) {
        if rememberTheOperand {
            operationPrioritet = operation
            operandArray.append(result)
           print(prioritetOperation)
            if operandArray.count > 2 && prioritetOperation == 2 {
               performTheOperation()
            }
            while operandArray.count > 1 && prioritetOperation == 3 {
                performTheOperation()
            }
            rememberTheOperand = false
        }
        if operation != "="{
        operationType.append(operation)
        }
        print(operandArray)
        print(operationType)
    }

    func unaryOperation (operation: String) {
        applyOperation(operationSymbol: operation)
    }
    
    func applyOperation(operationSymbol:String){
        print(operationType)
        if let operation = OperationDictionary[operationSymbol] {
            switch operation {
            case .UnaryOperation(let unaryFunction): resultValue = unaryFunction(result)
            case . BinaryOperation(let binaryFunction): resultValue = binaryFunction(firstOperand,secondOperand)
                print(firstOperand,secondOperand)
            case .Equals : return
                
            
            }
        }
    }
}
        

