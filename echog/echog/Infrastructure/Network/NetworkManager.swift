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
    
    init(baseURLResolver: BaseURLResolvable,
         plugins: [NetworkPluginProtocol] = []) {
        self.baseURLResolver = baseURLResolver
        self.plugins = plugins
    }
    
    // MARK: - Public
    func fetchData<Builder: NetworkBuilderProtocol>(_ builder: Builder) async throws -> Builder.Response {
        let request = try await makeRequest(builder)
        let (data, response) = try await URLSession.shared.data(for: request)
        if let string = String(data: data, encoding: .utf8) {
            print("Response Body:", string)
        }
        //Error
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

        var url = baseURL.appendingPathComponent(builder.path)
        url.append(queryItems: builder.queries ?? [])
        
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
    
//    private func configureQuery(_ query: [URLQueryItem]?) -> [URLQueryItem] {
//        var queries: [URLQueryItem] = []
//        
//        query?.forEach({ URLQueryItem in
//            queries.append(URLQueryItem)
//        })
//        
//        return queries
//    }
}
