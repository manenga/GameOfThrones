//
//  HouseListView.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import SwiftUI

/**
 A `HouseListView` represents a screen with a list of all the houses of Game of Thrones
*/
struct HouseListView: View {
    
    /// the view model that powers the `HouseListView`
    @ObservedObject var viewModel = HouseListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List(LocalData.shared.houseList) { house in
                    let houseDetailViewModel = HouseDetailViewModel(house: house)
                    NavigationLink(destination: HouseDetailView(viewModel: houseDetailViewModel)) {
                        VStack(alignment: .leading) {
                            Text(house.name)
                                .font(.headline)
                            if house.words.isNotEmpty {
                                Text(house.words)
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.gray)
                                Spacer()
                            }
                            if house.region.isNotEmpty {
                                HStack {
                                    Text("Region:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.red)
                                    Text(house.region)
                                        .font(.subheadline)
                                }
                            }
                            if house.coatOfArms.isNotEmpty {
                                VStack(alignment: .leading) {
                                    Text("Coat Of Arms:")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundColor(Color.orange)
                                    Text(house.coatOfArms)
                                        .font(.subheadline)
                                }
                            }
                        }
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }.navigationTitle("House Index")
        }
    }
}

struct HouseListView_Previews: PreviewProvider {
    static var previews: some View {
        HouseListView()
    }
}
