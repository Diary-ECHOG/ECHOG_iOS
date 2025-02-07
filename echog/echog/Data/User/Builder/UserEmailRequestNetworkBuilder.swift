//
//  UserEmailRequestNetworkBuilder.swift
//  echog
//
//  Created by minsong kim on 2/4/25.
//

import Foundation

struct UserEmailRequestNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = DefalutDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/users/request-verification" }
    var queries: [URLQueryItem]?
    var method: HTTPMethod { .post }
    var parameters: [String : Any] = [:]
    var deserializer: any NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())
    
    var useAuthorization: Bool = false
    
    init(email: String) {
        self.queries = [URLQueryItem(name: "email", value: email)]
    }
}
