//
//  Book.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/16.
//

import Foundation

/**
 A `Book` represents a book written about Game of Thrones
*/
struct Book: Codable, Identifiable {
    
    /// unique house Identifiable number
    var id = UUID()
    
    /// The hypermedia URL of this resource
    let url: String
    
    /// Books with the given name are included in the response
    let name: String
    
    /// keys used to query values from the json object
    enum CodingKeys: String, CodingKey {
        case url
        case name
    }
}
