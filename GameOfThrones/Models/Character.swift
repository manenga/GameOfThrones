//
//  Character.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Foundation

/**
 A `Character` represents a person in the Game of Thrones world
*/
struct Character: Codable, Identifiable, Hashable {
    
    /// unique house Identifiable number
    var id = UUID()
    
    /// The hypermedia URL of this resource
    let url: String
    
    /// The name of this character
    let name: String
    
    /// The gender of this character.
    let gender: String
    
    /// The culture that this character belongs to.
    let culture: String
    
    /// Textual representation of when and where this character was born.
    let born: String
    
    /// Textual representation of when and where this character died.
    let died: String
    
    /// The titles that this character holds.
    let titles: [String]
    
    /// The aliases that this character goes by.
    let aliases: [String]
    
    /// The character resource URL of this character's father.
    let father: String
    
    /// The character resource URL of this character's mother.
    let mother: String
    
    /// An array of Character resource URLs that has had a POV-chapter in this book.
    let spouse: String
    
    /// An array of House resource URLs that this character is loyal to.
    let allegiances: [String]
    
    /// An array of Book resource URLs that this character has been in.
    let books: [String]
    
    /// An array of Book resource URLs that this character has had a POV-chapter in.
    let povBooks: [String]
    
    /// An array of names of the seasons of Game of Thrones that this character has been in.
    let tvSeries: [String]
    
    /// An array of actor names that has played this character in the TV show Game Of Thrones.
    let playedBy: [String]

    /// keys used to query values from the json object
    enum CodingKeys: String, CodingKey {
        case url
        case name
        case gender
        case culture
        case born
        case died
        case titles
        case aliases
        case father
        case mother
        case spouse
        case allegiances
        case books
        case povBooks
        case tvSeries
        case playedBy
    }
}
