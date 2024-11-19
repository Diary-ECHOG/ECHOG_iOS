//
//  BaseURLManager.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

final class BaseURLManager: BaseURLResolvable, BaseURLRegistrable {
    private var baseURLMap: [BaseURLType: URL] = [:]

    func resolve(for type: BaseURLType) -> URL? {
        baseURLMap[type]
    }

    func register(_ url: URL, for type: BaseURLType) {
        baseURLMap[type] = url
    }
}
