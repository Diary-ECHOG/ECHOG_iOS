//
//  UserDTO.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

public struct UserDTO: Decodable, Sendable {
    public let statusCode: String
    public let message: String
    public let data: UserDataClass
}

public struct UserDataClass: Decodable, Sendable {
    public let email: String
    public let nickname: String
    public let token: String
    public let refreshToken: String
}
