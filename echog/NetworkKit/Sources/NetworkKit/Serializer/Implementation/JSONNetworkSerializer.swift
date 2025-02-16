//
//  JSONNetworkSerializer.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

public struct JSONNetworkSerializer: NetworkSerializable {
    public init() {}
    
    public func serialize(_ parameters: [String: Any]) throws -> Data {
        try JSONSerialization.data(withJSONObject: parameters)
    }
}
