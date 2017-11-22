//
//  FormatTextField+InputType.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

extension FormatTextField {

    /**
 
     The input type for a given
     
    */
    public enum InputType {
        /**
         
         Does not apply formatting or constraints. `FormatTextField` will always
         be valid.
         
        */
        case none
        
        /**
 
         Validates an email address.
         
         - Note:
         Does not constrain text in the `FormatTextField`. But will validate
         to see if the text is in fact an email. For insance a user could type
         an email of "👹asdf 2424.asdf.000", but that would have an `isValid`
         field on the `FormatTextField` as false.
         
        */
        case email
        
        /**
 
        Constrains text to an 10 digit phone number.
         
        Will be in the format (###) ###-####. For instance, if the phone number
        was 2018675309 it would be formatted as (201) 867-5309.
         
        */
        case phone
        
        /**
 
         Formats the text field's text as a currency using commas.
         
         - Parameter currencySymbol: The symbol for the currency. For instance,
           for U.S. Dollars "$".
         
         Will be in the format of <`currencySymbol`>##,###. For instance, if the
         currency symbol is "$" and the amount is 9300. The text will look like
         `$9,300`. Will be valid if the the text is all numbers and has a length
         greater than 0. Will be valid if all the digits are numbers and it is
         10 characters long.
         
        */
        case currency(currencySymbol: String)
        
        func clense(text: String) -> String {
            switch self {
            case .none:
                return text
            case .email:
                return text
            case .phone:
                var currText = text.removeOccurances(notInSet: self.set)
                if currText.count > 10 {
                    currText = String(currText.prefix(10))
                }
                return currText
            case .currency(currencySymbol: _):
                return text.removeOccurances(notInSet: self.set)
            }
        }
        
        func format(text: String) -> String {
            switch self {
            case.none:
                return text
            case .email:
                return text
            case .phone:
                var tempText = ""
                for (idx, char) in text.enumerated() {
                    switch idx {
                    case 0:
                        tempText.append("(\(char)")
                    case 1, 3, 4, 6, 7, 8, 9:
                        tempText.append(char)
                    case 2:
                        tempText.append("\(char)) ")
                    case 5:
                        tempText.append("\(char)-")
                    default:
                        break
                    }
                }
                return tempText
            case .currency(currencySymbol: let currencySymbol):
                guard let num = Double(text) else { return "" }
                let nf = NumberFormatter()
                nf.numberStyle = .currency
                nf.currencySymbol = currencySymbol
                nf.maximumFractionDigits = 0
                return nf.string(from: num as NSNumber)!
            }
        }
        
        func isValid(clensedText text: String) -> Bool {
            return regexPredicate?.evaluate(with: text) ?? true
        }
        
        var regexPredicate: NSPredicate? {
            switch self {
            case .none:
                return nil
            case .email:
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                return NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            case .phone:
                let phoneRegEx = "[0-9]{10}"
                return NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
            case .currency(currencySymbol: _):
                let currencyRegEx = "[0-9]+"
                return NSPredicate(format:"SELF MATCHES %@", currencyRegEx)
            }
        }
        
        var set: Set<Character> {
            switch self {
            case .none:
                return Set<Character>()
            case .email:
                return Set<Character>()
            case .phone:
                return Set<Character>("1234567890")
            case .currency(currencySymbol: _):
                return Set<Character>("1234567890")
            }
        }
    }
}
