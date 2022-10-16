//
//  LocalData.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/16.
//

import Combine
import Foundation

class LocalData: ObservableObject {
    
    static let shared = LocalData()
    
    @Published var houseList: [House] = []
    @Published var books: [String: Book] = [String: Book]()
    @Published var characters: [String: Character] = [String: Character]()
}
