//
//  UserRegisterNetworkBuilder.swift
//  echog
//
//  Created by minsong kim on 2/6/25.
//

import Foundation
import NetworkKit

struct UserRegisterNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = RegisterDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/users/register" }
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .post }
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { false }
}
