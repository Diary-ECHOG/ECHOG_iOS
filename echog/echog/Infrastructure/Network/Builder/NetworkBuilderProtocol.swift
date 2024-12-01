//
//  NetworkBuilderProtocol.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol NetworkBuilderProtocol {
    associatedtype Response: Decodable

    var baseURL: BaseURLType { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any] { get }
    var serializer: NetworkSerializable { get }
    var deserializer: NetworkDeserializable { get }

    var useAuthorization: Bool { get }
}

extension NetworkBuilderProtocol {
    var headers: [String: String] { ["Content-Type": "application/json"] }

    var serializer: NetworkSerializable {
        JSONNetworkSerializer()
    }
}
