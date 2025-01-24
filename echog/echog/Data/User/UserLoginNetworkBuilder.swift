//
//  UserLoginNetworkBuilder.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

struct UserLoginNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = UserDTO
    
    var method: HTTPMethod { .post }
    var baseURL: BaseURLType { .api }
    var path: String { "/auth/login" }
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { false }

    init(loginId: String, password: String) {
        self.parameters = [
            "loginId": loginId,
            "password": password
        ]
    }
}
