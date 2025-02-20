//
//  DiaryDeleteNetworkBuilder.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation
import NetworkKit

struct DiaryDeleteNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = String
    
    var baseURL: BaseURLType { .api }
    var path: String = "/api/diary/delete/"
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .delete }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(id: UUID) {
        self.path = "/api/diary/delete/\(id.uuidString)"
    }
}
