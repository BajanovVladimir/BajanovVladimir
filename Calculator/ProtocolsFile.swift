//
//  ProtocolsFile.swift
//  Calculator
//
//  Created by Владимир Бажанов on 9/23/21.
//
protocol KeyboardDataProtocol{
    func enteringNumberTransmission(number:String)
    func decimalPointTransmission()
    func operationTransmission(operationType: String)
    func cleanTrasmission()
    func removeTheLastCharesterTransmission()
    func unaryOperationTransmission(operationType:String)
}
protocol KeyboardDelegate {
    var inputDelegate: KeyboardDataProtocol? {get set}
}
