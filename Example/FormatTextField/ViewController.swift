//
//  ViewController.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/2017.
//  Copyright (c) 2017 Anthony Dito. All rights reserved.
//

import FormatTextField
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBOutlet weak var formatTextField: FormatTextField! {
        didSet {
            formatTextField.formatTextFieldDelegate = self
        }
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
        formatTextField.inputType = getInputTypeForSegment()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatTextField.inputType = getInputTypeForSegment()
    }
    
    private func getInputTypeForSegment() -> FormatTextField.InputType {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return .currency(currencySymbol: "$")
        case 1:
            return .email
        case 2:
            return .phone
        case 3:
            return .none
        default:
            fatalError("Unknown segment control index \(segmentControl.selectedSegmentIndex)")
        }
    }
}

extension ViewController: FormatTextFieldDelegate {
    func formatTextFieldTextChange(_ textField: FormatTextField, text: String, isValid: Bool) {
        print("\(isValid ? "✅" : "❌") Text changed to \(text) which \(isValid ? "is" : "is not") valid")
    }
}
