//
//  NetworkSession.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

final class NetworkSession: NetworkSessionProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        return try await session.data(for: request)
    }
}
