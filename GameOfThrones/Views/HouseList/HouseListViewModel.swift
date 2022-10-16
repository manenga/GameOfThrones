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
    @Published var isLoading: Bool = true
    
    var cancellableToken: AnyCancellable?
    
    init() {
        getHouses(currentPage: 1)
    }
    
    let perPage = 50
    private var cancellable: AnyCancellable?
    
}

extension HouseListViewModel {
    func getHouses(currentPage: Int) {
        cancellable = URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://anapioficeandfire.com/api/houses?page=\(currentPage)&pageSize=50")!)
            .tryMap { $0.data }
            .decode(type: [House].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .catch { _ in Just(self.houses) }
            .sink { [weak self] in
                self?.houses.append(contentsOf: $0)
                debugPrint("House count: \(self?.houses.count ?? 0)")

                if $0.count == self?.perPage ?? 50 {
                    debugPrint("New: \($0.count). Fecthing more for page \(currentPage + 1).")
                    self?.getHouses(currentPage: currentPage + 1)
                } else {
                    debugPrint("New: \($0.count). Done fecthing.")
                    self?.isLoading = false
                }
            }
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
