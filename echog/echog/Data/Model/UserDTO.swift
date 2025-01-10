//
//  UserDTO.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

struct UserDTO: Decodable {
    let email: String
    let nickname: String
    let token: String
    let refreshToken: String
}
