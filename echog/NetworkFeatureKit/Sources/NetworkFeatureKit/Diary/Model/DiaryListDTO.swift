//
//  DiaryListDTO.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation

public struct DiaryListDTO: Decodable {
    let content: [Content]
    let pageNumber: Int
    let pageSize: Int
    let totalElements: Int
    let totalPages: Int
}

public struct Content: Decodable {
    let id: UUID
    let title: String
    let content: String
    let createdAt: String
}
