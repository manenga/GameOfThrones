//
//  SearchBar.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/16.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var searching: Bool
    
    var body: some View {
        ZStack {
             Rectangle()
                 .foregroundColor(Color("LightGray"))
             HStack {
                 Image(systemName: "magnifyingglass")
                 TextField("Search...", text: $searchText) { startedEditing in
                     if startedEditing {
                         withAnimation {
                             searching = true
                         }
                     }
                 } onCommit: {
                     withAnimation {
                         searching = false
                     }
                 }
             }
             .foregroundColor(.gray)
             .padding(.leading, 13)
         }
         .frame(height: 40)
         .cornerRadius(13)
         .padding()
    }
}
