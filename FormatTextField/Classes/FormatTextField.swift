//
//  FormatTextField.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

public class FormatTextField: UITextField {
    
    public final var formatTextFieldDelegate: FormatTextFieldDelegate?
    
    public final var inputType: FormatTextField.InputType = .none {
        didSet {
            updateTextForInputTypeChange()
        }
    }
    
    public var formattedText: String {
        return text ?? ""
    }
    
    public var clensedText: String {
        return inputType.clense(text: text ?? "")
    }
    
    public var isValid: Bool {
        return inputType.isValid(clensedText: clensedText)
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        delegate = self
    }
    
    private func updateTextForInputTypeChange() {
        let values = inputType.clense(text: text!)
        let formatted = inputType.format(text: values)
        text = formatted
        formatTextFieldDelegate?.formatTextFieldTextChange(self, text: values, isValid: inputType.isValid(clensedText: values))
    }
}

extension FormatTextField: UITextFieldDelegate {
    
    /// :nodoc:
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let formatted = inputType.format(text: "")
        text = formatted
        formatTextFieldDelegate?.formatTextFieldTextChange(self, text: formatted, isValid: inputType.isValid(clensedText: ""))
        return true
    }
    
    /// :nodoc:
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nextText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        let lengthDiff = nextText.count - text!.count
        let prevRawValues = inputType.clense(text: text!)
        var rawValues = inputType.clense(text: nextText)
        if lengthDiff < 0 && prevRawValues.count <= rawValues.count {
            rawValues = String(rawValues[..<rawValues.index(before: rawValues.endIndex)])
        }
        let formatted = inputType.format(text: rawValues)
        text = formatted
        formatTextFieldDelegate?.formatTextFieldTextChange(self, text: rawValues, isValid: inputType.isValid(clensedText: rawValues))
        return false
    }
}
