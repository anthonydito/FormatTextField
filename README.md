# FormatTextField

[![CI Status](http://img.shields.io/travis/anthonydito/FormatTextField.svg?style=flat)](https://travis-ci.org/anthonydito/FormatTextField)
[![Version](https://img.shields.io/cocoapods/v/FormatTextField.svg?style=flat)](http://cocoapods.org/pods/FormatTextField)
[![License](https://img.shields.io/cocoapods/l/FormatTextField.svg?style=flat)](http://cocoapods.org/pods/FormatTextField)
[![Platform](https://img.shields.io/cocoapods/p/FormatTextField.svg?style=flat)](http://cocoapods.org/pods/FormatTextField)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

FormatTextField is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'FormatTextField'
```

## Usage

```swift
import FormatTextField

var textField = FormatTextField()
textField.inputType = .phone
```

The options for inputType are the following

- phone: Formats a phone number, for example (123) 456-7890
- currecy: Formats as a currency with a given currency symbol, for example $1,234
- email: Validates as an email

## Author

Anthony Dito, anthonymdito@gmail.com

## License

FormatTextField is available under the MIT license. See the LICENSE file for more info.
