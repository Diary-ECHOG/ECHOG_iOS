//
//  BaseURLRegistrable.swift
//  echog
//
//  Created by minsong kim on 11/19/24.
//

import Foundation

public protocol BaseURLRegistrable {
    func register(_ url: URL, for type: BaseURLType)
}
