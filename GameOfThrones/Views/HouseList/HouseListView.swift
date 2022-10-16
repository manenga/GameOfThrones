//
//  HouseListView.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import SwiftUI

struct HouseListView: View {
    
    @ObservedObject var viewModel = HouseListViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.houses) { house in
                    let houseDetailViewModel = HouseDetailViewModel(house: house)
                    NavigationLink(destination: HouseDetailView(viewModel: houseDetailViewModel)) {
                        VStack(alignment: .leading) {
                            Text(house.name)
                                .font(.headline)
                            if house.words.isNotEmpty {
                                Text(house.words)
                                    .font(.subheadline)
                                    .fontWeight(.bold)
                            }
                            if house.region.isNotEmpty {
                                Text("Region: \(house.region)")
                                    .font(.subheadline)
                            }
                            if house.coatOfArms.isNotEmpty {
                                Text("Coat Of Arms: \(house.coatOfArms)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }.navigationTitle("Houses")
        }
    }
}

struct HouseListView_Previews: PreviewProvider {
    
    static var previews: some View {
        HouseListView()
    }
}
