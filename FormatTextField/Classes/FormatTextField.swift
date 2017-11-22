//
//  FormatTextField.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

public class FormatTextField: UITextField {
    
    public var inputType: FormatTextField.InputType = .phone {
        didSet {
            updateTextForInputTypeChange()
        }
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
        self.delegate = self
    }
    
    private func updateTextForInputTypeChange() {
        let values = inputType.clense(text: text!)
        let formatted = inputType.format(text: values)
        text = formatted
    }
}

extension FormatTextField: UITextFieldDelegate {
    
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
        return false
    }
}
