//
//  LocalData.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/16.
//

import Combine
import Foundation

public final class LocalData: ObservableObject {
    // shared instance so we only have 1 instance per session
    static let shared = LocalData()
    // a list that stores alls the houses
    @Published var houseList: [House] = []
    // a list that stores alls the books
    @Published var books: [String: Book] = [String: Book]()
    // a list that stores alls the characters
    @Published var characters: [String: Character] = [String: Character]()
}
