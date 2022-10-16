//
//  HouseDetailViewModel.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

class HouseDetailViewModel {
    
    var house: House?
    var cancellableToken: AnyCancellable? = nil
    
    init(house: House? = nil) {
        self.house = house
    }
}

extension HouseDetailViewModel {
    func getHouse(id: String) -> House? {
        return LocalData.shared.houseList.first(where: { $0.url == "https://anapioficeandfire.com/api/houses/\(id)" })
    }
    
    func getCharacter(id: String) -> Character? {
        if let character = LocalData.shared.characters[id] {
            return character
        }
        return nil
    }
    
    func fetchCharacter(id: String) {
        guard LocalData.shared.characters[id] == nil else { return }
        // if we already have the Character, no need to fetch it!
        cancellableToken = Network.request(character: id)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { character in
                LocalData.shared.characters[id] = character
            })
    }
}
