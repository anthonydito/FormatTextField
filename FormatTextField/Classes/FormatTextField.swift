//
//  FormatTextField.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import UIKit

/**
 
 The `FormatTextField` provides formatted `UITextField`.
 
 - Attention:
 Using the `UITextFieldDelegate` should *NOT* be used on this class. Use the
 `FormatTextFieldDelegate` protocol (which implements all the methods of the
 `UITextFieldDelegate` protocol instead).
 
*/
open class FormatTextField: UITextField {
    
    /// The delegate that will recieve events relating to this FormatTextField.
    public final var formatTextFieldDelegate: FormatTextFieldDelegate?

    /// The input type of the
    /// - Note: Chaning the input type will trigger the delegates
    /// `formatTextFieldTextChange` method.
    public final var inputType: FormatTextField.InputType = .none {
        didSet {
            updateTextForInputTypeChange()
        }
    }
    
    /// The formatted text. Simply the text that is displayed to the user. This
    /// will work even if a `UITextFieldDelegate` is used on this class.
    public var formattedText: String {
        return inputType.format(text: inputType.clense(text: self.text ?? ""))
    }
    
    /// The clensed text that removes all formatting characters. For instance,
    /// the parenthesis on a phone number.
    public var clensedText: String {
        return inputType.clense(text: text ?? "")
    }
    
    /// Whether the input is valid for the particular input type.
    public var isValid: Bool {
        return inputType.isValid(clensedText: clensedText)
    }
    
    /// :nodoc:
    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    /// :nodoc:
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
    
    // MARK: Methods intercepted from UITextFieldDelegate
    
    /// Uses the method to update the text of the text based on the `inputType`.
    /// One should use the `formatTextFieldDelegate`s
    /// `formatTextFieldTextChange` to get notified when this method is called.
    /// Always returns true as the text change is handled based on the input
    /// type.
    public final func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let nextText = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
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
    
    // MARK: Methods rerouted to `FormatTextFieldDelegate`
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`. And if
    /// true, will update the text based on the `inputType`.
    public final func textFieldShouldClear(_ textField: UITextField) -> Bool {
        let shouldCancel = self.formatTextFieldDelegate?.textFieldShouldClear?(textField) ?? true
        if shouldCancel {
            let formatted = inputType.format(text: "")
            text = formatted
            formatTextFieldDelegate?.formatTextFieldTextChange(self, text: formatted, isValid: inputType.isValid(clensedText: ""))
        }
        return shouldCancel
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    public final func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return formatTextFieldDelegate?.textFieldShouldBeginEditing?(textField) ?? true
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    public final func textFieldDidBeginEditing(_ textField: UITextField) {
        formatTextFieldDelegate?.textFieldDidBeginEditing?(textField)
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    public final func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return formatTextFieldDelegate?.textFieldShouldEndEditing?(textField) ?? true
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    @available(iOS 10.0, *)
    public final func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        formatTextFieldDelegate?.textFieldDidEndEditing?(textField, reason: reason)
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    public final func textFieldDidEndEditing(_ textField: UITextField) {
        formatTextFieldDelegate?.textFieldDidEndEditing?(textField)
    }
    
    /// Calls the corresponding method on the `formatTextFieldDelegate`.
    public final func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return formatTextFieldDelegate?.textFieldShouldReturn?(textField) ?? false
    }
}
