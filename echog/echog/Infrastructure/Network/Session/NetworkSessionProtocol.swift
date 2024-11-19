//
//  NetworkSessionProtocol.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol NetworkSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}
