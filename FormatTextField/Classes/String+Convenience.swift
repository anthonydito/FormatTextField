//
//  String+Convenience.swift
//  FormatTextField
//
//  Created by Anthony Dito on 11/20/17.
//

import Foundation

extension String {
    func removeOccurances(notInSet set: Set<Character>) -> String {
        return self.reduce(String()) { (prevResult, currCharacter) -> String in
            if set.contains(currCharacter) {
                var tempResult = prevResult
                tempResult.append(currCharacter)
                return tempResult
            } else {
                return prevResult
            }
        }
    }
}
