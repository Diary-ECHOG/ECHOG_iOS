//
//  DiaryNetwork.swift
//  NetworkFeatureKit
//
//  Created by minsong kim on 2/17/25.
//

import Foundation
import NetworkKit

public final class DiaryNetwork: @unchecked Sendable {
    public static let shared = DiaryNetwork()
    
    private var networkManager = NetworkManager(baseURLResolver: BaseURLManager())

    private init() {}
    
    public func configureNetworkManager(_ baseURLResolver: BaseURLResolvable) {
        self.networkManager = NetworkManager(baseURLResolver: baseURLResolver)
    }
    
    public func requestDiaryList(page: Int, size: Int) async throws -> DiaryListDTO {
        let builder = DiaryViewNetworkBuilder(page: page, size: size)
        return try await networkManager.fetchData(builder)
    }
    
    public func createDiary(title: String, content: String) async throws -> DiaryDTO {
        let builder = DiaryWriteNetworkBuilder(parameters: [ "title": title, "content": content])
        return try await networkManager.fetchData(builder)
    }
    
    public func uploadDiary(id: UUID, title: String, content: String) async throws -> DiaryDTO {
        let builder = DiaryWriteNetworkBuilder(parameters: ["id": id.uuidString, "title": title, "content": content])
        return try await networkManager.fetchData(builder)
    }
    
    public func deleteDiary(id: UUID) async throws -> String {
        let builder = DiaryDeleteNetworkBuilder(id: id)
        return try await networkManager.fetchData(builder)
    }
}
