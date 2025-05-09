//
//  DiaryWriteNetworkBuilder.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation
import NetworkKit

struct DiaryWriteNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = DiaryDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/diary/write" }
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .post }
    let parameters: [String: Any]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
}
