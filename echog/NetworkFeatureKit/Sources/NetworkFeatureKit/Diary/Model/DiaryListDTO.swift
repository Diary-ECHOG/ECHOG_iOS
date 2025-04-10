//
//  DiaryListDTO.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation

public struct DiaryListDTO: Decodable, Sendable {
    public let content: [DiaryContent]
    public let pageNumber: Int
    public let pageSize: Int
    public let totalElements: Int
    public let totalPages: Int
}

public struct DiaryContent: Decodable, Hashable, Sendable {
    public let id: UUID
    public var title: String
    public var content: String
    public let createdAt: String
    public var createdDate: Date? {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_KR")
        // 시간대 정보 없이 소수점 이하 6자리까지 처리하는 포맷
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        // 만약 시간대 정보 없이 로컬 타임존으로 해석하고 싶다면:
        formatter.timeZone = TimeZone.current
        
        return formatter.date(from: createdAt)
    }
    public var formattedDate: String {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "MM월 dd일 EEEE"
        
        return formatter.string(from: createdDate ?? Date())
    }
    
    public init(id: UUID, title: String, content: String, createdAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.createdAt = createdAt
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    public static func == (lhs: DiaryContent, rhs: DiaryContent) -> Bool {
        return lhs.id == rhs.id
    }
}
