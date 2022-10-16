//
//  UIApplicationExtensions.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/16.
//

import UIKit
import Foundation

extension UIApplication {
    func dismissKeyboard() {
        // helper to dismiss keyboard when we're done searching
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
