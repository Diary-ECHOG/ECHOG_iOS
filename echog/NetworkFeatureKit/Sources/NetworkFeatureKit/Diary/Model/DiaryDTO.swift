//
//  DiaryDTO.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation

public struct DiaryDTO: Decodable {
    let id: UUID
    let title: String
    let content: String
}
