//
//  NetworkManager.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

final class NetworkManager {
    private let baseURLResolver: BaseURLResolvable
    private let plugins: [NetworkPluginProtocol]
    private let session: NetworkSessionProtocol
    
    init(baseURLResolver: BaseURLResolvable,
         plugins: [NetworkPluginProtocol],
         session: NetworkSessionProtocol) {
        self.baseURLResolver = baseURLResolver
        self.plugins = plugins
        self.session = session
    }
    
    // MARK: - Public
    func fetchData<Builder: NetworkBuilderProtocol>(_ builder: Builder) async throws -> Builder.Response {
        let request = try await makeRequest(builder)
        let (data, response) = try await session.data(for: request)
        let decodedData: Builder.Response = try await builder.deserializer.deserialize(data)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.responseNotFound
        }
        
        if (200...299).contains(httpResponse.statusCode) {
            return decodedData
        } else {
            print(httpResponse.statusCode)
            throw NetworkError.invalidStatus(httpResponse.statusCode)
        }
    }
    
    // MARK: - Private
    private func makeRequest<Builder: NetworkBuilderProtocol>(_ builder: Builder) async throws -> URLRequest {
        guard let baseURL = baseURLResolver.resolve(for: builder.baseURL) else {
            throw NetworkError.urlNotFound
        }

        let url = baseURL.appendingPathComponent(builder.path)
        var request = URLRequest(url: url)
        builder.headers.forEach { (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if builder.useAuthorization {
            let accesstoken = KeyChain.read(key: .accessToken) ?? ""
            request.setValue("Bearer \(accesstoken)", forHTTPHeaderField: "Authorization")
        }
        
        request.httpMethod = builder.method.typeName
        request.httpBody = try await builder.serializer.serialize(builder.parameters)
        return plugins.reduce(request) { $1.prepare($0) }
    }
}
