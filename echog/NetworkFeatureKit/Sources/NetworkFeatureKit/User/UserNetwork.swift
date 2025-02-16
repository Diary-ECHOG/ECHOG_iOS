//
//  UserNetwork.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation
import NetworkKit

public final class UserNetwork: @unchecked Sendable {
    public static let shared = UserNetwork()
    
    private var networkManager = NetworkManager(baseURLResolver: BaseURLManager())

    private init() {}
    
    public func configureNetworkManager(_ baseURLResolver: BaseURLResolvable) {
        self.networkManager = NetworkManager(baseURLResolver: baseURLResolver)
    }
    
    public func emailCodeRequest(email: String) async throws -> DefalutDTO {
        let builder = UserEmailRequestNetworkBuilder(email: email)
        return try await networkManager.fetchData(builder)
    }
    
    public func checkCode(email: String, code: String) async throws -> DefalutDTO {
        let builder = UserCodeCheckNetworkBuilder(parameters: ["email":email, "token": code])
        return try await networkManager.fetchData(builder)
    }
    
    public func register(email: String, password: String, agreement: Bool) async throws -> RegisterDTO {
        let builder = UserRegisterNetworkBuilder(parameters: ["nickname": "", "email": email, "passworkd": password, "agreement": agreement, "anonymous": true])
        return try await networkManager.fetchData(builder)
    }

    public func login(email: String, password: String) async throws -> UserDTO {
        let builder = UserLogInNetworkBuilder(loginId: email, password: password)
        return try await networkManager.fetchData(builder)
    }
}
