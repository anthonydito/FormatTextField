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
        case currency(currencySymbol: String, allowsDecimal: Bool)
        
        func clense(text: String) -> String {
            switch self {
            case .none:
                return text
            case .email:
                return text
            case .phone:
                return text.removeOccurances(notInSet: self.set)
            case .currency(currencySymbol: _, allowsDecimal: let allowsDecimal):
                let baseText = text.removeOccurances(notInSet: self.set)
                if allowsDecimal {
                    var tempText = ""
                    var decimalPointIdx: Int?
                    for (idx, char) in baseText.enumerated() {
                        if char == "." {
                            if decimalPointIdx == nil {
                                decimalPointIdx = idx
                                tempText.append(char)
                            } else {
                                continue
                            }
                        } else if decimalPointIdx != nil && idx > decimalPointIdx! + 1 {
                            continue
                        } else {
                            tempText.append(char)
                        }
                    }
                    return tempText
                } else {
                    return baseText
                }
                // if allows decimal, need to remove any digits more than 2 past the decimal point
            }
        }
        
        func format(text: String) -> String {
            switch self {
            case.none:
                return text
            case .email:
                return text
            case .phone:
                return text
            case .currency(currencySymbol: let currencySymbol, allowsDecimal: let allowsDecimal):
                guard let num = Double(text) else { return "" }
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                if allowsDecimal {
                    nf.maximumFractionDigits = 2
                } else {
                    nf.maximumFractionDigits = 0
                }
                return "\(currencySymbol)\(nf.string(from: num as NSNumber)!)"
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
            case .currency(currencySymbol: _, allowsDecimal: let allowsDecimal):
                if allowsDecimal {
                    return Set<Character>("1234567890.")
                } else {
                    return Set<Character>("1234567890")
                }
            }
        }
    }
}
