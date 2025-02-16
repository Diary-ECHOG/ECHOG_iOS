//
//  HTTP.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

public enum HTTPMethod {
    case get
    case put
    case post
    case patch
    case delete
    
    var typeName: String {
        switch self {
        case .get:
            return "GET"
        case .put:
            return "PUT"
        case .post:
            return "POST"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
