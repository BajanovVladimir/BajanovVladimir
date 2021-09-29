//
//  ProtocolsFile.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/23/21.
//

protocol KeyboardDataProtocol {
    func enteringNumberTransmission(number:String)
    func decimalPointTransmission()
    func operationTransmission(operationType: String)
    func equalTransmission()
    func cleanTrasmission()
    func removeTheLastCharesterTransmission()
    func signChangeTransmission()
    func squareRootTransmission()
}

protocol KeyboardDelegate {
    var inputDelegate: KeyboardDataProtocol? {get set}
}
