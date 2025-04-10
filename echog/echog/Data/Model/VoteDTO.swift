//
//  VoteDTO.swift
//  echog
//
//  Created by minsong kim on 2/12/25.
//

import Foundation

struct VoteDTO: Codable, Hashable {
    let id: String
    let category: String
    let title: String
    let content1: String
    let content2: String
    let content3: String
    let content4: String
    let content5: String
    let content1Count: Int
    let content2Count: Int
    let content3Count: Int
    let content4Count: Int
    let content5Count: Int
    let endTime: String
    let result: String
    var totalCount: Int {
        return content1Count + content2Count + content3Count + content4Count + content5Count
    }
    
    enum CodingKeys: String, CodingKey {
        case id, category, title, content1, content2, content3, content4, content5
        case content1Count = "content1cnt"
        case content2Count = "content2cnt"
        case content3Count = "content3cnt"
        case content4Count = "content4cnt"
        case content5Count = "content5cnt"
        case endTime, result
    }
}
