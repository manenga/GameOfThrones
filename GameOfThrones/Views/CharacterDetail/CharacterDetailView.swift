//
//  CharacterDetailView.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel = CharacterDetailViewModel()
    var character: Character?
    
    init(viewModel: CharacterDetailViewModel = CharacterDetailViewModel(), character: Character? = nil) {
        self.viewModel = viewModel
        self.character = character
        populateBooks()
        populateHouses()
        populateCharacters()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                name
                basicInfoGroup
                supplymentaryInfoGroup
                Spacer()
            }
        }
    }
}

private extension CharacterDetailView {
    
    @ViewBuilder
    var name: some View {
        if
            let character = character,
            character.name.isNotEmpty {
            Text(character.name)
                .font(.title)
                .fontWeight(.bold)
        }
    }

    @ViewBuilder
    var gender: some View {
        if
            let character = character,
            character.gender.isNotEmpty {
            HStack(spacing: 4) {
                Text("Gender: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(character.gender)
                    .font(.subheadline)
            }
        }
    }
    
    @ViewBuilder
    var culture: some View {
        if
            let character = character,
            character.culture.isNotEmpty {
            HStack(spacing: 4) {
                Text("Culture: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(character.culture)
                    .font(.subheadline)
            }
        }
    }
    
    @ViewBuilder
    var born: some View {
        if
            let character = character,
            character.born.isNotEmpty {
            HStack(spacing: 4) {
                Text("Born: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(character.born)
                    .font(.subheadline)
            }
        }
    }
    
    @ViewBuilder
    var died: some View {
        if
            let character = character,
            character.died.isNotEmpty {
            HStack(spacing: 4) {
                Text("Died: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(character.died)
                    .font(.subheadline)
            }
        }
    }
    
    @ViewBuilder
    var father: some View {
        if
            let character = character,
            character.father.isNotEmpty {
            HStack(spacing: 4) {
                Text("Father: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let father = getCharacterByUrl(character.father) {
                    NavigationLink(destination: CharacterDetailView(character: father)) {
                        Text(father.name).font(.subheadline)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var mother: some View {
        if
            let character = character,
            character.mother.isNotEmpty {
            HStack(spacing: 4) {
                Text("Mother: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let mother = getCharacterByUrl(character.mother) {
                    NavigationLink(destination: CharacterDetailView(character: mother)) {
                        Text(mother.name).font(.subheadline)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var spouse: some View {
        HStack(spacing: 4) {
            Text("Spouse: ")
                .font(.subheadline)
                .fontWeight(.semibold)
            if
                let character = character,
                let spouse = getCharacterByUrl(character.spouse) {
                NavigationLink(destination: CharacterDetailView(character: spouse)) {
                    Text(spouse.name).font(.subheadline)
                }
            } else {
                Text("none").font(.subheadline)
            }
        }
    }
    
    @ViewBuilder
    var titles: some View {
        if
            let character = character,
            character.titles.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Official Titles:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.titles, id: \.self) { title in
                    Text(title).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var aliases: some View {
        if
            let character = character,
            character.aliases.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Aliases:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.aliases, id: \.self) { title in
                    Text(title).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var basicInfoGroup: some View {
        VStack(alignment: .leading, spacing: 0) {
            gender
            culture
            born
            died
            titles
            aliases
            father
            mother
            spouse
        }
    }
    
    @ViewBuilder
    var allegiances: some View {
        if
            let character = character,
            character.allegiances.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Allegiances:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.allegiances, id: \.self) { house in
                    if let house = getHouseByUrl(house) {
                        NavigationLink(destination: HouseDetailView(viewModel: HouseDetailViewModel(house: house))) {
                            Text(house.name).font(.subheadline)
                        }
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var books: some View {
        if
            let character = character,
            character.books.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Books:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.books, id: \.self) { book in
                    if let book = getBookByUrl(book) {
                        Text(book.name).font(.subheadline)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var povBooks: some View {
        if
            let character = character,
            character.povBooks.isNotEmpty {
            VStack(alignment: .leading) {
                Text("PovBooks:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.povBooks, id: \.self) { book in
                    Text(book).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var tvSeries: some View {
        if
            let character = character,
            character.tvSeries.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Tv Series:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.tvSeries, id: \.self) { series in
                    Text(series).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var playedBy: some View {
        if
            let character = character,
            character.playedBy.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Played By:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(character.playedBy, id: \.self) { name in
                    Text(name).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var supplymentaryInfoGroup: some View {
        Group {
            allegiances
            books
            povBooks
            tvSeries
            playedBy
        }
    }
}

extension CharacterDetailView {
    
    private func populateCharacters() {
        if let character = character {
            if let index = character.spouse.lastIndex(of: "/") {
                let id = String(character.spouse.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
            if let index = character.father.lastIndex(of: "/") {
                let id = String(character.father.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
            if let index = character.mother.lastIndex(of: "/") {
                let id = String(character.mother.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
        }
    }
    
    private func populateHouses() {
        if let character = character {
            let _ = character.allegiances.compactMap({ house in
                if let index = house.lastIndex(of: "/") {
                    let id = String(house.suffix(from: index).dropFirst())
                    viewModel.fetchCharacter(id: id)
                }
            })
        }
    }
    
    private func populateBooks() {
        if let character = character {
            let _ = character.books.compactMap({ house in
                if let index = house.lastIndex(of: "/") {
                    let id = String(house.suffix(from: index).dropFirst())
                    viewModel.fetchBook(id: id)
                }
            })
            let _ = character.povBooks.compactMap({ house in
                if let index = house.lastIndex(of: "/") {
                    let id = String(house.suffix(from: index).dropFirst())
                    viewModel.fetchBook(id: id)
                }
            })
        }
    }
    
    private func getCharacterByUrl(_ url: String) -> Character? {
        if
            let index = url.lastIndex(of: "/") {
            let id = String(url.suffix(from: index).dropFirst())
            return viewModel.getCharacter(id: id)
        }
        return nil
    }
    
    private func getHouseByUrl(_ url: String) -> House? {
        if
            let index = url.lastIndex(of: "/") {
            let id = String(url.suffix(from: index).dropFirst())
            return viewModel.getHouse(id: id)
        }
        return nil
    }
    
    private func getBookByUrl(_ url: String) -> Book? {
        if
            let index = url.lastIndex(of: "/") {
            let id = String(url.suffix(from: index).dropFirst())
            return viewModel.getBook(id: id)
        }
        return nil
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return CharacterDetailView()
    }
}
