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
                // result.response.Headers.Link
                // "<https://anapioficeandfire.com/api/houses?page=2&pageSize=10>;
                // rel=\"next\", <https://anapioficeandfire.com/api/houses?page=1&pageSize=10>;
                // rel=\"first\", <https://anapioficeandfire.com/api/houses?page=45&pageSize=10>; rel=\"last\""
                let payload = try JSONDecoder().decode(T.self, from: result.data)
                return Response(value: payload, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher() 
    }
}
