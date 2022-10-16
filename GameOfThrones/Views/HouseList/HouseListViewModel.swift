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
    
    @Published var character: Character?
    @Published var isLoading: Bool = true
    
    private var cancellableToken: AnyCancellable?
    
    init() {
        // start looking for houses as soon as we are created.
        getHouses(currentPage: 1)
    }
}

extension HouseListViewModel {
    func getHouses(currentPage: Int) {
        cancellableToken = URLSession.shared
            .dataTaskPublisher(for: URL(string: "\(Network.baseUrl)houses?page=\(currentPage)&pageSize=50")!)
            .tryMap { $0.data }
            .decode(type: [House].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .catch { _ in Just(LocalData.shared.houseList) }
            .sink { [weak self] in
                LocalData.shared.houseList.append(contentsOf: $0)
                if $0.count == 50 {
                    self?.getHouses(currentPage: currentPage + 1)
                } else {
                    self?.isLoading = false
                }
            }
    }
}
