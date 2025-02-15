//
//  UserNetwork.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation
import NetworkModule

final class UserNetwork {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func emailCodeRequest(email: String) async throws -> DefalutDTO {
        let builder = UserEmailRequestNetworkBuilder(email: email)
        return try await networkManager.fetchData(builder)
    }
    
    func checkCode(email: String, code: String) async throws -> DefalutDTO {
        let builder = UserCodeCheckNetworkBuilder(parameters: ["email":email, "token": code])
        return try await networkManager.fetchData(builder)
    }
    
    func register(email: String, password: String, agreement: Bool) async throws -> RegisterDTO {
        let builder = UserRegisterNetworkBuilder(parameters: ["nickname": "", "email": email, "passworkd": password, "agreement": agreement, "anonymous": true])
        return try await networkManager.fetchData(builder)
    }

    func login(email: String, password: String) async throws -> UserDTO {
        let builder = UserLogInNetworkBuilder(loginId: email, password: password)

        return try await networkManager.fetchData(builder)
    }
}
