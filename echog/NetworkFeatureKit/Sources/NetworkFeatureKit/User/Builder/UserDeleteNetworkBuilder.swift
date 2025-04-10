//
//  UserDeleteNetworkBuilder.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/27/25.
//

import Foundation
import NetworkKit

struct UserDeleteNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = DefalutDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/users/delete" }
    var queries: [URLQueryItem]?
    var method: HTTPMethod { .post }
    var parameters: [String : Any] = [:]
    var deserializer: any NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool = true
}
