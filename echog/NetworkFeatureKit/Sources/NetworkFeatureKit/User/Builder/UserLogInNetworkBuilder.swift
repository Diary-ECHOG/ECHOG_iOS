//
//  UserLogInNetworkBuilder.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation
import NetworkKit

struct UserLogInNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = UserDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/users/login" }
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .post }
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
