//
//  FormatTextFieldDelegate.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/22/17.
//



public protocol FormatTextFieldDelegate {
    
    func formatTextFieldTextChange(_ textField: FormatTextField, text: String, isValid: Bool)
    
}
