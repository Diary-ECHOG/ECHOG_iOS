//
//  NetworkSerializable.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol NetworkSerializable {
    func serialize(_ parameters: [String: Any]) async throws -> Data
}
