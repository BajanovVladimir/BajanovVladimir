//
//  ProtocolsFile.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/23/21.
//

protocol KeyboardDataProtocol {
    func numberButtonPress(data:String)
    func operationEntryButtonPress(data:String)
    func equalButtonPress()
    func cleanButtonPress()
    func remaveTheLastCharesterButtonPress()
    func signChangeButtonPress()
    func squareRootButtonPress()
    func decimalPointSettingButtonPress()
    func percentButtonPress()
    func unitDividedByNumberButtonPress()
    func degreeNumberButtonPress()
    func tenToThePowerNumberButtonPress()
    func factorialNumberButtonPress()
}
