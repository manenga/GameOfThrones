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

extension Network {
    // TODO: (manenga) for security enums are better to use here for the path, not string
    static func request(_ path: String) -> AnyPublisher<[House], Error> {
        guard var components = URLComponents(url: baseUrl.appendingPathComponent(path), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        components.queryItems = [URLQueryItem(name: "pageSize", value: "50")]
        let request = URLRequest(url: components.url!)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
        // TODO: (manenga) handle pagnation:
        // https://stackoverflow.com/questions/59767427/what-combine-operator-approach-can-be-used-to-load-all-pages-of-paged-api
        // https://www.donnywals.com/recursively-execute-a-paginated-network-call-with-combine/
        // https://anapioficeandfire.com/Documentation#pagination
    }
    
    static func request(character id: String) -> AnyPublisher<Character, Error> {
        guard let components = URLComponents(url: baseUrl.appendingPathComponent("characters/\(id)"), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        let request = URLRequest(url: components.url!)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    static func request(house id: String) -> AnyPublisher<House, Error> {
        guard let components = URLComponents(url: baseUrl.appendingPathComponent("house/\(id)"), resolvingAgainstBaseURL: true)
            else { fatalError("Couldn't create URLComponents") }
        let request = URLRequest(url: components.url!)
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
