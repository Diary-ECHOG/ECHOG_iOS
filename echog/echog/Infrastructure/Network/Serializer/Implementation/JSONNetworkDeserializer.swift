//
//  JSONNetworkDeserializer.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

struct JSONNetworkDeserializer: NetworkDeserializable {
    private let decoder: JSONDecoder

    init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
