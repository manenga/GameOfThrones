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
    @Published var characters: [String: Character] = [String: Character]()
    var cancellableToken: AnyCancellable? = nil
    
    init(house: House? = nil) {
        self.house = house
    }
}

extension HouseDetailViewModel {
    func getHouse(id: String) -> House? {
        return LocalData.shared.houseList.first(where: { $0.url == "https://anapioficeandfire.com/api/houses/\(id)" })
    }
    
    func getCharacter(id: String) {
        cancellableToken = Network.request(character: id)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { [weak self] in
                self?.characters[id] = $0
            })
    }
}
