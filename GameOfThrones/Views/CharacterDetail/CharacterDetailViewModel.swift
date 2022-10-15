//
//  CharacterDetailViewModel.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

class CharacterDetailViewModel: ObservableObject {
    
    @Published var character: Character?
    var cancellableToken: AnyCancellable?
}

// TODO: make a protocol for looking up this stuff that all these view models comform to
extension CharacterDetailViewModel {
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
