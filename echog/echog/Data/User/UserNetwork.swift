//
//  UserNetwork.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

final class UserNetwork {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func emailCodeRequest(email: String) async throws -> DefalutDTO {
        let builder = UserEmailRequestNetworkBuilder(email: email)
        return try await networkManager.fetchData(builder)
    }

    func login(email: String, password: String, completion: @escaping (Result<UserDTO, Error>) -> Void) {
        let builder = UserLogInNetworkBuilder(loginId: email, password: password)

        Task {
            do {
                let user = try await networkManager.fetchData(builder)
                KeyChain.create(key: .accessToken, data: user.token)
                KeyChain.create(key: .refreshToken, data: user.refreshToken)
                print(user.nickname)
                print(user.email)
                completion(.success(user))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
