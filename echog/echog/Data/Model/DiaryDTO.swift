//
//  DiaryDTO.swift
//  echog
//
//  Created by minsong kim on 12/11/24.
//

import Foundation

struct DiaryDTO: Codable, Hashable {
    let id: Int
    let createDate: Date
    let title: String
    let content: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case createDate = "createDt"
        case title
        case content
        case userID = "userId"
    }
}
