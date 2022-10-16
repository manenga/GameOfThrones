//
//  Network.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

enum Network {
    static let apiClient = APIClient()
    static let baseUrl = URL(string: "https://anapioficeandfire.com/api/")!
}

enum APIPath: String {
    case book = "books"
    case house = "houses"
    case character = "characters"
}

extension Network {    
    
    static func request(character id: String) -> AnyPublisher<Character, Error> {
        return makeRequest(path: .character, id: id)
    }
    
    static func request(house id: String) -> AnyPublisher<House, Error> {
        return makeRequest(path: .house, id: id)
    }
    
    static func request(book id: String) -> AnyPublisher<Book, Error> {
        return makeRequest(path: .book, id: id)
    }
    
    private static func makeRequest<T: Decodable>(path: APIPath, id: String) -> AnyPublisher<T, Error> {
        guard let components = URLComponents(url: baseUrl.appendingPathComponent("\(path.rawValue)/\(id)"), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        let request = URLRequest(url: components.url!)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
