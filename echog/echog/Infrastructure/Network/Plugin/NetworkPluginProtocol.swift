//
//  NetworkPluginProtocol.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

protocol NetworkPluginProtocol {
    func prepare(_ request: URLRequest) -> URLRequest
}
