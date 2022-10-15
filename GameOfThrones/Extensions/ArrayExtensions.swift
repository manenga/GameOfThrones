//
//  ArrayExtensions.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Foundation


extension Array {
    var isNotEmpty: Bool {
        guard self.count > 0 else { return false }
        if let first = self.first as? String {
            return first.isNotEmpty
        } else {
            return true
        }
    }
}
