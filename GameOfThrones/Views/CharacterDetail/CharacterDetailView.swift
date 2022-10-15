//
//  CharacterDetailView.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @ObservedObject var viewModel = CharacterDetailViewModel()
    var characterId: String
    
    init(viewModel: CharacterDetailViewModel = CharacterDetailViewModel(), characterId: String) {
        self.viewModel = viewModel
        self.characterId = characterId
        self.viewModel.getCharacter(id: characterId)
    }
    
    var body: some View {
        ScrollView() {
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

    var character: Character? {
        viewModel.character
    }
    
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
                if let index = character.father.lastIndex(of: "/") {
                    let id = String(character.father.suffix(from: index).dropFirst())
                    NavigationLink(destination: CharacterDetailView(characterId: id)) {
                        Text("tap to view").font(.subheadline)
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
                if let index = character.mother.lastIndex(of: "/") {
                    let id = String(character.mother.suffix(from: index).dropFirst())
                    NavigationLink(destination: CharacterDetailView(characterId: id)) {
                        Text("tap to view").font(.subheadline)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var spouse: some View {
        if
            let character = character,
            character.spouse.isNotEmpty {
            HStack(spacing: 4) {
                Text("Spouse: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let index = character.spouse.lastIndex(of: "/") {
                    let id = String(character.spouse.suffix(from: index).dropFirst())
                    NavigationLink(destination: CharacterDetailView(characterId: id)) {
                        Text("tap to view").font(.subheadline)
                    }
                }
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
                ForEach(character.allegiances, id: \.self) { title in
                    Text(title).font(.subheadline)
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
                ForEach(character.books, id: \.self) { title in
                    Text(title).font(.subheadline)
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
                ForEach(character.povBooks, id: \.self) { title in
                    Text(title).font(.subheadline)
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
                ForEach(character.tvSeries, id: \.self) { title in
                    Text(title).font(.subheadline)
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
                ForEach(character.playedBy, id: \.self) { title in
                    Text(title).font(.subheadline)
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

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        return CharacterDetailView(characterId: "25")
    }
}
