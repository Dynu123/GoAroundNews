//
//  String+extension.swift
//  GoAroundNewsApp
//
//  Created by Dyana Varghese on 08/12/22.
//

import Foundation

extension String {
    
    var camelCaseToWords: Self {
        unicodeScalars.reduce("") { CharacterSet.uppercaseLetters.contains($1) ? "\($0) \($1)" : "\($0)\($1)" }.capitalized
    }
    
    var capitalizeFirstLetter: Self {
        prefix(1).capitalized + dropFirst()
    }

    var camelCaseToSentence: Self {
        camelCaseToWords.lowercased().capitalizeFirstLetter
    }
}
