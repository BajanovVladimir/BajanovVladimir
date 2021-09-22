//
//  ProtocolsFile.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/22/21.


protocol KeyboardDataProtocol {
    func numberButtonPress(data:String)
    func operationEntryButtonPress(data:String)
    func equalButtonPress(data:String)
    func cleanButtonPress(data:String)
    func remaveTheLastCharesterButtonPress(data:String)
    func signChangeButtonPress(data:String)
    func squareRootButtonPress(data:String)
    func decimalPointSettingButtonPress()
    func percentButtonPress()
    func unitDividedByNumberButtonPress()
    func degreeNumberButtonPress()
    func tenToThePowerNumberButtonPress()
    func factorialNumberButtonPress()
}

