//
//  HouseListViewModel.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

class HouseListViewModel: ObservableObject {
    
    @Published var houses: [House] = []
    @Published var character: Character?
    
    var cancellableToken: AnyCancellable?
    
    init() {
        getHouses()
    }
    
}

extension HouseListViewModel {
    func getHouses() {
        cancellableToken = Network.request("houses")
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                debugPrint("House count: \($0.count)")
                debugPrint($0.map({ $0.name }))
                self.houses = $0
                // TODO: (manenga) do we want to capture self like this here?
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
