//
//  HouseDetailView.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import SwiftUI

struct HouseDetailView: View {
    
    var viewModel: HouseDetailViewModel
    
    init(viewModel: HouseDetailViewModel) {
        self.viewModel = viewModel
        populateCharacters()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                name
                basicInfoGroup
                founded
                coatOfArms
                LeadershipGroup
                supplymentaryInfoGroup
                Spacer()
            }
        }.padding(16)
    }
}

private extension HouseDetailView {

    var house: House? {
        viewModel.house
    }
    
    @ViewBuilder
    var name: some View {
        if
            let house = house,
            house.name.isNotEmpty {
            Text(house.name)
                .font(.title)
                .fontWeight(.bold)
        }
    }

    @ViewBuilder
    var words: some View {
        if
            let house = house,
            house.words.isNotEmpty {
            VStack(alignment: .leading, spacing: 4) {
                Text(house.words)
                    .font(.subheadline)
                    .foregroundColor(Color.gray)
            }
        }
    }
    
    @ViewBuilder
    var region: some View {
        if
            let house = house,
            house.region.isNotEmpty {
            VStack(alignment: .leading, spacing: 4) {
                Text("Region: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(house.region)
                    .font(.subheadline).foregroundColor(.yellow)
            }
        }
    }
    
    @ViewBuilder
    var basicInfoGroup: some View {
        Group {
            words
            region
        }
    }
    
    @ViewBuilder
    var LeadershipGroup: some View {
        Group {
            titles
            seats
            currentLord
            heir
            overlord
            founder
        }
    }
    
    @ViewBuilder
    var supplymentaryInfoGroup: some View {
        Group {
            ancestralWeapons
            cadetBranches
            swornMembers
        }
    }
    
    @ViewBuilder
    var founded: some View {
        if
            let house = house,
            house.founded.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Since:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(house.founded).font(.subheadline)
            }
        } else if
            let house = house,
            house.diedOut.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Until:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(house.diedOut).font(.subheadline)
            }
        }
    }
        
    @ViewBuilder
    var coatOfArms: some View {
        if
            let house = house,
            house.coatOfArms.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Coat Of Arms:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(house.coatOfArms).font(.subheadline).foregroundColor(Color.red)
            }
        }
    }
    
    @ViewBuilder
    var titles: some View {
        if
            let house = house,
            house.titles.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Official Titles:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(house.titles, id: \.self) { title in
                    Text(title).font(.subheadline)
                }
            }
        }
    }
    
    @ViewBuilder
    var seats: some View {
        if
            let house = house,
            house.seats.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Seats:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                ForEach(house.seats, id: \.self) { seat in
                    Text(seat).font(.subheadline).foregroundColor(.mint)
                }
            }
        }
    }
    
    @ViewBuilder
    var currentLord: some View {
        if
            let house = house,
            house.currentLord.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Current Lord:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let character = getCharacterByUrl(house.currentLord) {
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        Text(character.name).font(.subheadline)
                    }
                } else {
                    Text("none").font(.subheadline).foregroundColor(Color.red)
                }
            }
        }
    }
    
    @ViewBuilder
    var heir: some View {
        VStack(alignment: .leading) {
            Text("Heir:")
                .font(.subheadline)
                .fontWeight(.semibold)
            if
                let heir = house?.heir,
                let character = getCharacterByUrl(heir) {
                NavigationLink(destination: CharacterDetailView(character: character)) {
                    Text(character.name).font(.subheadline)
                }
            } else {
                Text("none").font(.subheadline).foregroundColor(Color.red)
            }
        }
    }
    
    @ViewBuilder
    var overlord: some View {
        if
            let house = house,
            house.overlord.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Overlord:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let house = getHouseByUrl(house.overlord) {
                    NavigationLink(destination: HouseDetailView(viewModel: HouseDetailViewModel(house: house))) {
                        Text(house.name).font(.subheadline)
                    }
                } else {
                    Text("none").font(.subheadline).foregroundColor(Color.red)
                }
            }
        }
    }
    
    @ViewBuilder
    var founder: some View {
        if
            let house = house,
            house.founder.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Founder:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let character = getCharacterByUrl(house.founder) {
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        Text(character.name).font(.subheadline)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var ancestralWeapons: some View {
        if
            let house = house,
            house.ancestralWeapons.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Ancestral Weapons:")
                    .font(.subheadline).fontWeight(.bold)
                ForEach(house.ancestralWeapons, id: \.self) { weapon in
                    Text(weapon).font(.subheadline).foregroundColor(Color.red)
                }
            }
        }
    }
    
    var branches: [House] {
        if
            let house = house,
            house.cadetBranches.isNotEmpty{
            return house.cadetBranches.compactMap({ getHouseByUrl($0) })
        }
        return []
    }
    
    @ViewBuilder
    var cadetBranches: some View {
        if
            branches.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Cadet Branches:")
                    .font(.subheadline).fontWeight(.bold)
                ForEach(branches, id: \.self) { cadetBranch in
                    NavigationLink(destination: HouseDetailView(viewModel: HouseDetailViewModel(house: cadetBranch))) {
                        Text(cadetBranch.name).font(.subheadline)
                    }
                }
            }
        }
    }
    
    var members: [Character] {
        if
            let house = house,
            house.swornMembers.isNotEmpty{
            return house.swornMembers.compactMap({ getCharacterByUrl($0) })
        }
        return []
    }
    
    @ViewBuilder
    var swornMembers: some View {
        if
            members.isNotEmpty {
            VStack(alignment: .leading) {
                Text("Sworn Members:")
                    .font(.subheadline).fontWeight(.bold)
                ForEach(members, id: \.self) { member in
                    NavigationLink(destination: CharacterDetailView(character: member)) {
                        Text(member.name).font(.subheadline)
                    }
                }
            }
        }
    }
}

extension HouseDetailView {
    
    private func populateCharacters() {
        if let house = house {
            if let index = house.heir.lastIndex(of: "/") {
                let id = String(house.heir.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
            if let index = house.currentLord.lastIndex(of: "/") {
                let id = String(house.currentLord.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
            if let index = house.founder.lastIndex(of: "/") {
                let id = String(house.founder.suffix(from: index).dropFirst())
                viewModel.fetchCharacter(id: id)
            }
            
            let _ = house.swornMembers.compactMap({ member in
                if let index = member.lastIndex(of: "/") {
                    let id = String(member.suffix(from: index).dropFirst())
                    viewModel.fetchCharacter(id: id)
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
}

struct HouseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let house = House(
            url: "https://anapioficeandfire.com/api/houses/378",
            name: "House Targaryen of King's Landing",
            region: "The Crownlands",
            coatOfArms: "Sable, a dragon thrice-headed gules",
            words: "Fire and Blood",
            titles: [
                "King of the Andals, the Rhoynar and the First Men",
                "Lord of the Seven Kingdoms",
                "Prince of Summerhall"
            ],
            seats: [
                "Red Keep (formerly)",
                "Summerhall (formerly)"
            ],
            currentLord: "https://anapioficeandfire.com/api/characters/1303",
            heir: "",
            overlord: "",
            founded: "House Targaryen: >114 BCHouse Targaryen of King's Landing:1 AC",
            founder: " ",
            diedOut: "",
            ancestralWeapons: [
                "Blackfyre",
                "Dark Sister"
            ],
            cadetBranches: [
                "https://anapioficeandfire.com/api/houses/23",
                "https://anapioficeandfire.com/api/houses/23"
            ],
            swornMembers: [
                "https://anapioficeandfire.com/api/characters/33",
                "https://anapioficeandfire.com/api/characters/42",
                "https://anapioficeandfire.com/api/characters/43",
                "https://anapioficeandfire.com/api/characters/2128"
            ])
        let viewModel = HouseDetailViewModel(house: house)
        HouseDetailView(viewModel: viewModel)
    }
}
