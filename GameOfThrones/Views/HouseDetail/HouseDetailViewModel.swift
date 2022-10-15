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
    @Published var character: Character?
    var cancellableToken: AnyCancellable?
    
    init(house: House? = nil,
         houseId: String? = nil,
         character: Character? = nil,
         cancellableToken: AnyCancellable? = nil) {
        self.house = house
        self.character = character
        self.cancellableToken = cancellableToken
        guard
            house == nil,
            let houseId = houseId
        else { return }
        getHouse(id: houseId)
    }
}

extension HouseDetailViewModel {
    func getHouse(id: String) {
        cancellableToken = Network.request(house: id)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                debugPrint("House found: \($0)")
                self.house = $0
            })
    }
    
    func getCharacter(id: String) {
        cancellableToken = Network.request(character: id)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                debugPrint("Character found: \($0)")
                self.character = $0
            })
    }
}
