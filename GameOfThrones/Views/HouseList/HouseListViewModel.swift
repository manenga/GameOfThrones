//
//  HouseListViewModel.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

/**
 A `HouseListViewModel` represents the view model that has the business logic and data models pertaining to the `HouseListView
*/
class HouseListViewModel: ObservableObject {
    
//    @Published var houses: [House] = []
    @Published var character: Character?
    @Published var isLoading: Bool = true
    
    private var cancellableToken: AnyCancellable?
    
    init() {
        getHouses(currentPage: 1)
    }
}

extension HouseListViewModel {
    func getHouses(currentPage: Int) {
        cancellableToken = URLSession.shared
            .dataTaskPublisher(for: URL(string: "https://anapioficeandfire.com/api/houses?page=\(currentPage)&pageSize=50")!)
            .tryMap { $0.data }
            .decode(type: [House].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .catch { _ in Just(LocalData.shared.houseList) }
            .sink { [weak self] in
                LocalData.shared.houseList.append(contentsOf: $0)
                debugPrint("House count: \(LocalData.shared.houseList.count)")

                if $0.count == 50 {
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
                self.character = $0
            })
    }
}
