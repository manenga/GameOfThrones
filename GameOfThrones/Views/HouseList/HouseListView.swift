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
    @State var searchText: String = ""
    @State var searching = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                SearchBar(searchText: $searchText, searching: $searching)
                List(getHouseIndex()) { house in
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
                .gesture(
                    DragGesture()
                        .onChanged({ _ in
                            UIApplication.shared.dismissKeyboard()
                        })
                 )
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationTitle(searching ? "Searching" : "House Index")
            .toolbar {
                 if searching {
                     Button("Cancel") {
                         searchText = ""
                         withAnimation {
                             searching = false
                         }
                     }
                 }
             }
        }
    }
}

extension HouseListView {
    private func getHouseIndex() -> [House] {
        if searching && searchText.isNotEmpty {
            return LocalData.shared.houseList.filter({ $0.name.contains(searchText) })
        } else {
            return LocalData.shared.houseList
        }
    }
}

struct HouseListView_Previews: PreviewProvider {
    static var previews: some View {
        HouseListView()
    }
}
