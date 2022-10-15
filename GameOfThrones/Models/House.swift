//
//  House.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Foundation

struct House: Codable, Identifiable {
    
    /// unique house Identifiable number
    var id = UUID()
    
    /// The hypermedia URL of this resource
    let url: String
    
    /// The name of this house
    let name: String
    
    /// The region that this house resides in.
    let region: String
    
    /// Text describing the coat of arms of this house.
    let coatOfArms: String
    
    /// The words of this house.
    let words: String
    
    /// The titles that this house holds.
    let titles: [String]
    
    /// The seats that this house holds.
    let seats: [String]
    
    /// The Character resource URL of this house's current lord.
    let currentLord: String
    
    /// The Character resource URL of this house's heir.
    let heir: String
    
    /// The House resource URL that this house answers to.
    let overlord: String
    
    /// The year that this house was founded.
    let founded: String
    
    /// The Character resource URL that founded this house.
    let founder: String
    
    /// The year that this house died out.
    let diedOut: String
    
    /// An array of names of the noteworthy weapons that this house owns.
    let ancestralWeapons: [String]
    
    /// An array of House resource URLs that was founded from this house.
    let cadetBranches: [String]
    
    /// An array of Character resource URLs that are sworn to this house.
    let swornMembers: [String]
    

    enum CodingKeys: String, CodingKey {
        case url
        case name
        case region
        case coatOfArms
        case words
        case titles
        case seats
        case currentLord
        case heir
        case overlord
        case founded
        case founder
        case diedOut
        case ancestralWeapons
        case cadetBranches
        case swornMembers
    }
}
