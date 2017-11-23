//
//  FormatTextFieldDelegate.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/22/17.
//

import UIKit

/**
 
 `FormatTextField` delegate that extends the `UITextFieldDelegate` and adds
 functionality for checking if text is valid on change.
 
*/
public protocol FormatTextFieldDelegate: UITextFieldDelegate {
    
    /**
     
     Notifies the delegate that the text in the text field has changed
     
     - Parameter textField: The text field that had it's text changed.
     
     - Parameter text: The new text that is present in the `textField` minus any
       formatting characters (such as parenthesis on a phone number).
    
     - Parameter isValid: Whether or not the text is valid as per the `inputType`
       parameter on the `FormatTextField`
     
    */
    func formatTextFieldTextChange(_ textField: FormatTextField, text: String, isValid: Bool)
    
}
