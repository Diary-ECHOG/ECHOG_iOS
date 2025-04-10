//
//  DiaryViewNetworkBuilder.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation
import NetworkKit

struct DiaryViewNetworkBuilder: NetworkBuilderProtocol {
    typealias Response = DiaryListDTO
    
    var baseURL: BaseURLType { .api }
    var path: String { "/api/diary/view" }
    var queries: [URLQueryItem]? = nil
    var method: HTTPMethod { .get }
    let parameters: [String: Any] = [:]
    let deserializer: NetworkDeserializable = JSONNetworkDeserializer(decoder: JSONDecoder())

    var useAuthorization: Bool { true }
    
    init(page: Int, size: Int) {
        self.queries = [URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "size", value: "\(size)")]
    }
}
