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

extension CharacterDetailViewModel {
    func getHouse(id: String) -> House? {
        return LocalData.shared.houseList.first(where: { $0.url == "\(Network.baseUrl)houses/\(id)" })
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
    
    func getBook(id: String) -> Book? {
        if let book = LocalData.shared.books[id] {
            return book
        }
        return nil
    }
    
    func fetchBook(id: String) {
        guard LocalData.shared.books[id] == nil else { return }
        // if we already have the book, no need to fetch it!
        cancellableToken = Network.request(book: id)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: { book in
                LocalData.shared.books[id] = book
            })
    }
}
