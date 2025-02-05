//
//  BaseURLManager.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

//개발 서버와 라이브 서버를 교체할 수 있도록 (QA용)
final class BaseURLManager: BaseURLResolvable, BaseURLRegistrable {
    private var baseURLMap: [BaseURLType: URL] = [:]

    func resolve(for type: BaseURLType) -> URL? {
        baseURLMap[type]
    }

    func register(_ url: URL, for type: BaseURLType) {
        baseURLMap[type] = url
    }
}
