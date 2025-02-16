//
//  JSONNetworkDeserializer.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

public struct JSONNetworkDeserializer: NetworkDeserializable {
    let decoder: JSONDecoder

    public init(decoder: JSONDecoder) {
        self.decoder = decoder
    }

    public func deserialize<T: Decodable>(_ data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
