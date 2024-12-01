//
//  NetworkDeserializable.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol NetworkDeserializable {
    func deserialize<T: Decodable>(_ data: Data) async throws -> T
}
