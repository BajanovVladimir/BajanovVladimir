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
    var operandArray = [Double]()
    var operationType = [String]()
    var priority = 0
    var  priorityOfThePreviousOperation = 0
    var firstOperand = 0.0
    var secondOperand = 0.0
    var theOperationBeingPerformed = ""
    var result:Double {
        get {
            return resultValue
        }
    }
    
    enum PriorityOperationEnum {
      
        case multiplay
        case division
        case addition
        case subtraction
        case equals
       
        var priority: Int {
            switch self {
            case .multiplay, .division:
                return 1
            case .addition, .subtraction, .equals:
                return 2
            
            }
        }
    }
    
    func operationPriority(operationSing:String) -> Int {
        switch operationSing {
        case "×":
            return PriorityOperationEnum.multiplay.priority
        case "÷":
            return PriorityOperationEnum.division.priority
        case "+":
            return PriorityOperationEnum.addition.priority
        case "-":
            return PriorityOperationEnum.subtraction.priority
        case "=":
            return PriorityOperationEnum.equals.priority
        default:
            return 0
        }
    }
    
    func setOperand(operand:Double){
        resultValue = operand
        }

    func typeOfOperation(operation:String){
        operandArray.append(result)
        priority = operationPriority(operationSing: operation)
       if operandArray.count > 1 {
            if priority == 1 && priorityOfThePreviousOperation == 1 {
                theOperationBeingPerformed = operationType.removeLast()
                secondOperand = operandArray.removeLast()
                firstOperand = operandArray.removeLast()
                resultValue = calculatingOperands(operationSign: theOperationBeingPerformed)
                operandArray.append(result)
            }
            while operationType.count > 0 && priority == 2 {
            theOperationBeingPerformed = operationType.removeLast()
            secondOperand = operandArray.removeLast()
            firstOperand = operandArray.removeLast()
            resultValue = calculatingOperands(operationSign: theOperationBeingPerformed)
            operandArray.append(result)
            }
        }
        if operation != "=" {
        operationType.append(operation)
        priorityOfThePreviousOperation = operationPriority(operationSing: operation)
        } else {
            operandArray = []
        }
    }
    
    func binaryOperation (_ operationTwo:(Double, Double) -> Double) -> Double {
        return  operationTwo(firstOperand, secondOperand)
    }
    
    func squareRoot (_ number:Double) ->Double {
        if number < 0 {
            error = true
            return 0
        }
        return sqrt(number)
    }
    func unitDividedBy(_ number:Double) -> Double {
        if number == 0 {
            error = true
            return 0
        }
        return 1/number
    }
    
    func degreeOfTen (_ degree:Double) -> Double {
        if degree < 0 {
            error = true
            return 0
        }
        return pow(10,degree)
    }
    
    func factorial(_ number:Double) -> Double {
        var result = 1
        let intFlag = number.truncatingRemainder(dividingBy: 1)
        print (intFlag)
        if intFlag != 0 || number < 0 {
            error = true
            return 0
            }
        let intNumber = Int(number)
            for counter in 1...intNumber {
                result *= counter
            }
        return Double(result)
    }
    
    func unaryOperation (operation: String) {
        switch operation {
        case "√" : resultValue = squareRoot(result)
        case "+/-": resultValue = -result
        case "1/x" : resultValue = unitDividedBy(result)
        case "n!": resultValue = factorial(result)
        case "10ⁿ" : resultValue = degreeOfTen(result)
        case "%": resultValue = percent(result)
        default: break
        }
    }
    
    func percent (_ persent: Double) -> Double {
        if operandArray.count < 1 {
            firstOperand = 1
        } else {
            firstOperand = operandArray.removeLast()
        }
        operandArray.append(firstOperand)
        return firstOperand*persent/100
    }
    
    func calculatingOperands(operationSign:String) -> Double {
        switch operationSign {
        case "+":
            return binaryOperation({$0+$1})
        case "-":
            return binaryOperation({$0-$1})
        case "÷":
            if secondOperand == 0 {
                error = true
                return 0
            }
            return binaryOperation({$0/$1})
        case "×":
            return binaryOperation({$0*$1})
        case "xⁿ":
            return pow(firstOperand,secondOperand)
        default:
            return 0
        }
    }
}
        

