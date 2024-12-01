//
//  NetworkError.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

enum NetworkError: Error {
    case urlNotFound
    case responseNotFound
    case invalidStatus(Int)
}
