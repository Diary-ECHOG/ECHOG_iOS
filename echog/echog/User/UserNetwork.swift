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

    func login(email: String, password: String, completion: @escaping (Result<UserDTO, Error>) -> Void) {
        let builder = UserLoginNetworkBuilder(loginId: email, password: password)

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
