//
//  FormatTextField+InputType.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

extension FormatTextField {

    public enum InputType {
        case none
        case email
        case phone
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
