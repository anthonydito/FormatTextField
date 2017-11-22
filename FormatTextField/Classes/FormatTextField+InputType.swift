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
                return text.removeOccurances(notInSet: self.set)
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
