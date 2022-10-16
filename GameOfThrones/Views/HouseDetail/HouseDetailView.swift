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
                Text("Words: ")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Text(house.words)
                    .font(.subheadline)
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
                    .font(.subheadline)
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
                Text(house.coatOfArms).font(.subheadline)
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
                    Text(seat).font(.subheadline)
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
                Text("Lord:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                if let character = getCharacterByUrl(house.currentLord) {
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        Text(character.name).font(.subheadline)
                    }
                } else {
                    Text("none").font(.subheadline)
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
                Text("none").font(.subheadline)
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
                    Text("none").font(.subheadline)
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
                    Text(weapon).font(.subheadline)
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
            debugPrint("Looking for branch id: \(id)")
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
                "https://anapioficeandfire.com/api/characters/44",
                "https://anapioficeandfire.com/api/characters/45",
                "https://anapioficeandfire.com/api/characters/48",
                "https://anapioficeandfire.com/api/characters/49",
                "https://anapioficeandfire.com/api/characters/55",
                "https://anapioficeandfire.com/api/characters/58",
                "https://anapioficeandfire.com/api/characters/59",
                "https://anapioficeandfire.com/api/characters/76",
                "https://anapioficeandfire.com/api/characters/91",
                "https://anapioficeandfire.com/api/characters/93",
                "https://anapioficeandfire.com/api/characters/109",
                "https://anapioficeandfire.com/api/characters/110",
                "https://anapioficeandfire.com/api/characters/154",
                "https://anapioficeandfire.com/api/characters/155",
                "https://anapioficeandfire.com/api/characters/156",
                "https://anapioficeandfire.com/api/characters/157",
                "https://anapioficeandfire.com/api/characters/161",
                "https://anapioficeandfire.com/api/characters/168",
                "https://anapioficeandfire.com/api/characters/169",
                "https://anapioficeandfire.com/api/characters/195",
                "https://anapioficeandfire.com/api/characters/239",
                "https://anapioficeandfire.com/api/characters/265",
                "https://anapioficeandfire.com/api/characters/266",
                "https://anapioficeandfire.com/api/characters/269",
                "https://anapioficeandfire.com/api/characters/270",
                "https://anapioficeandfire.com/api/characters/271",
                "https://anapioficeandfire.com/api/characters/272",
                "https://anapioficeandfire.com/api/characters/275",
                "https://anapioficeandfire.com/api/characters/276",
                "https://anapioficeandfire.com/api/characters/330",
                "https://anapioficeandfire.com/api/characters/334",
                "https://anapioficeandfire.com/api/characters/361",
                "https://anapioficeandfire.com/api/characters/488",
                "https://anapioficeandfire.com/api/characters/546",
                "https://anapioficeandfire.com/api/characters/560",
                "https://anapioficeandfire.com/api/characters/576",
                "https://anapioficeandfire.com/api/characters/610",
                "https://anapioficeandfire.com/api/characters/611",
                "https://anapioficeandfire.com/api/characters/696",
                "https://anapioficeandfire.com/api/characters/709",
                "https://anapioficeandfire.com/api/characters/729",
                "https://anapioficeandfire.com/api/characters/759",
                "https://anapioficeandfire.com/api/characters/767",
                "https://anapioficeandfire.com/api/characters/779",
                "https://anapioficeandfire.com/api/characters/797",
                "https://anapioficeandfire.com/api/characters/865",
                "https://anapioficeandfire.com/api/characters/867",
                "https://anapioficeandfire.com/api/characters/868",
                "https://anapioficeandfire.com/api/characters/869",
                "https://anapioficeandfire.com/api/characters/870",
                "https://anapioficeandfire.com/api/characters/871",
                "https://anapioficeandfire.com/api/characters/872",
                "https://anapioficeandfire.com/api/characters/873",
                "https://anapioficeandfire.com/api/characters/874",
                "https://anapioficeandfire.com/api/characters/875",
                "https://anapioficeandfire.com/api/characters/876",
                "https://anapioficeandfire.com/api/characters/951",
                "https://anapioficeandfire.com/api/characters/971",
                "https://anapioficeandfire.com/api/characters/1067",
                "https://anapioficeandfire.com/api/characters/1070",
                "https://anapioficeandfire.com/api/characters/1079",
                "https://anapioficeandfire.com/api/characters/1114",
                "https://anapioficeandfire.com/api/characters/1142",
                "https://anapioficeandfire.com/api/characters/1205",
                "https://anapioficeandfire.com/api/characters/1242",
                "https://anapioficeandfire.com/api/characters/1302",
                "https://anapioficeandfire.com/api/characters/1303",
                "https://anapioficeandfire.com/api/characters/1340",
                "https://anapioficeandfire.com/api/characters/1358",
                "https://anapioficeandfire.com/api/characters/1445",
                "https://anapioficeandfire.com/api/characters/1450",
                "https://anapioficeandfire.com/api/characters/1469",
                "https://anapioficeandfire.com/api/characters/1520",
                "https://anapioficeandfire.com/api/characters/1523",
                "https://anapioficeandfire.com/api/characters/1527",
                "https://anapioficeandfire.com/api/characters/1528",
                "https://anapioficeandfire.com/api/characters/1548",
                "https://anapioficeandfire.com/api/characters/1549",
                "https://anapioficeandfire.com/api/characters/1560",
                "https://anapioficeandfire.com/api/characters/1589",
                "https://anapioficeandfire.com/api/characters/1608",
                "https://anapioficeandfire.com/api/characters/1709",
                "https://anapioficeandfire.com/api/characters/1739",
                "https://anapioficeandfire.com/api/characters/1826",
                "https://anapioficeandfire.com/api/characters/1856",
                "https://anapioficeandfire.com/api/characters/1867",
                "https://anapioficeandfire.com/api/characters/1872",
                "https://anapioficeandfire.com/api/characters/1873",
                "https://anapioficeandfire.com/api/characters/1874",
                "https://anapioficeandfire.com/api/characters/1897",
                "https://anapioficeandfire.com/api/characters/1944",
                "https://anapioficeandfire.com/api/characters/1948",
                "https://anapioficeandfire.com/api/characters/1978",
                "https://anapioficeandfire.com/api/characters/1981",
                "https://anapioficeandfire.com/api/characters/2071",
                "https://anapioficeandfire.com/api/characters/2086",
                "https://anapioficeandfire.com/api/characters/2124",
                "https://anapioficeandfire.com/api/characters/2128"
            ])
        let viewModel = HouseDetailViewModel(house: house)
        HouseDetailView(viewModel: viewModel)
    }
}
