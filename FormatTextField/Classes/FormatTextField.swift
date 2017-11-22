//
//  FormatTextField.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

public class FormatTextField: UITextField {
    
    public var inputType: FormatTextField.InputType = .phone
    
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
}

extension FormatTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nextText = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
        let rawValues = inputType.clense(text: nextText)
        let formatted = inputType.format(text: rawValues)
        text = formatted
        return false
    }
}
