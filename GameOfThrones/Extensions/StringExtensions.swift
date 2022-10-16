//
//  StringExtensions.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Foundation

extension String {
    // remove all spaces and check if the string is empty
    var isNotEmpty: Bool {
        return !String(self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)).isEmpty
    }
}
