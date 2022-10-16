//
//  APIClient.swift
//  GameOfThrones
//
//  Created by Manenga on 2022/10/15.
//

import Combine
import Foundation

struct APIClient {

    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func run<T: Decodable>(_ request: URLRequest) -> AnyPublisher<Response<T>, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { result -> Response<T> in
                let payload = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: payload, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() 
    }
}
