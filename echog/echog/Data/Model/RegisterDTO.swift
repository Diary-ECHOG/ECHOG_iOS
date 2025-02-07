//
//  RegisterDTO.swift
//  echog
//
//  Created by minsong kim on 2/6/25.
//

struct RegisterDTO: Decodable {
    let statusCode: String
    let message: String
    let data: DataClass
}

struct DataClass: Decodable {
    let createdAt: String
    let updatedAt: String
    let id: String
    let nickname: String
    let email: String
    let password: String
    let agreement: Bool
    let enabled: Bool
    let anonymous: Bool
    let deleted: Bool
}
